'use strict';

var child_process = require('child_process');
var obsidian = require('obsidian');
var fs = require('fs');
var os = require('os');
var path = require('path');

/******************************************************************************
Copyright (c) Microsoft Corporation.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
***************************************************************************** */
/* global Reflect, Promise, SuppressedError, Symbol, Iterator */


function __awaiter(thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
}

typeof SuppressedError === "function" ? SuppressedError : function (error, suppressed, message) {
    var e = new Error(message);
    return e.name = "SuppressedError", e.error = error, e.suppressed = suppressed, e;
};

const resolveCommandManager = (app) => {
    const maybeCommands = app.commands;
    if (maybeCommands &&
        typeof maybeCommands.findCommand === 'function' &&
        typeof maybeCommands.removeCommand === 'function') {
        return maybeCommands;
    }
    return null;
};

const logger = {
    enabled: false,
    setEnabled(value) {
        this.enabled = value;
    },
    log(...args) {
        if (this.enabled) {
            console.debug('[open-in-terminal]', ...args);
        }
    }
};

const sanitizeTerminalApp = (value) => value.trim();
const escapeDoubleQuotes = (value) => value.replace(/"/g, '\\"');
const escapeForCmdQuotedString = (value) => value.replace(/"/g, '""');
const toWslPath = (windowsPath) => {
    const normalized = windowsPath.replace(/\\/g, '/');
    const match = normalized.match(/^([A-Za-z]):\/(.*)$/);
    if (!match) {
        return null;
    }
    const drive = match[1].toLowerCase();
    const rest = match[2];
    return `/mnt/${drive}/${rest}`;
};
const getPlatformSummary = () => {
    if (obsidian.Platform.isDesktopApp) {
        if (obsidian.Platform.isMacOS) {
            return 'desktop-macos';
        }
        if (obsidian.Platform.isWin) {
            return 'desktop-windows';
        }
        if (obsidian.Platform.isLinux) {
            return 'desktop-linux';
        }
        return 'desktop-unknown';
    }
    if (obsidian.Platform.isMobileApp) {
        if (obsidian.Platform.isIosApp) {
            return 'mobile-ios';
        }
        if (obsidian.Platform.isAndroidApp) {
            return 'mobile-android';
        }
        return 'mobile-unknown';
    }
    return 'unknown';
};
const ensureTempScript = (content) => {
    const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'open-in-terminal-'));
    const filePath = path.join(dir, 'launch.command');
    logger.log('Creating temp script', { dir, filePath });
    fs.writeFileSync(filePath, content, { mode: 0o755 });
    const cleanup = () => {
        try {
            fs.rmSync(dir, { recursive: true, force: true });
            logger.log('Cleaned temp script', dir);
        }
        catch (error) {
            console.warn('[open-in-terminal] Failed to remove temp script', error);
        }
    };
    return { path: filePath, cleanup };
};
const buildMacLaunch = (terminalApp, vaultPath, toolCommand) => {
    const app = sanitizeTerminalApp(terminalApp);
    if (!app) {
        return null;
    }
    if (!toolCommand) {
        const escapedApp = escapeDoubleQuotes(app);
        const escapedPath = escapeDoubleQuotes(vaultPath);
        const command = `open -a "${escapedApp}" "${escapedPath}"`;
        logger.log('macOS simple launch', { app, command, vaultPath });
        return { command };
    }
    const escapedVaultPath = escapeDoubleQuotes(vaultPath);
    const scriptLines = ['#!/bin/bash', `cd "${escapedVaultPath}"`];
    if (toolCommand) {
        scriptLines.push(toolCommand);
    }
    scriptLines.push('exec "$SHELL"');
    const { path, cleanup } = ensureTempScript(scriptLines.join('\n'));
    const command = `open -a "${escapeDoubleQuotes(app)}" "${path}"`;
    logger.log('macOS script launch', { app, command, script: path, toolCommand });
    return { command, cleanup };
};
const buildWindowsLaunch = (terminalApp, vaultPath, toolCommand, useWslOnWindows) => {
    const app = sanitizeTerminalApp(terminalApp);
    if (!app) {
        return null;
    }
    const escapedVault = vaultPath.replace(/"/g, '"');
    const cdCommand = `cd /d "${escapedVault}"`;
    const tool = toolCommand ? ` && ${toolCommand}` : '';
    const lowerApp = app.toLowerCase();
    if (useWslOnWindows) {
        const wslVaultPath = toWslPath(vaultPath);
        if (!wslVaultPath) {
            logger.log('Windows WSL launch skipped due to unsupported path', { vaultPath });
            return null;
        }
        const wslPrefix = `wsl.exe --cd "${escapeForCmdQuotedString(wslVaultPath)}"`;
        const wslCommand = toolCommand ? `${wslPrefix} ${toolCommand}` : wslPrefix;
        if (lowerApp === 'cmd.exe' || lowerApp === 'cmd') {
            const command = `start "" cmd.exe /K "${wslCommand}"`;
            logger.log('Windows launch (cmd.exe + WSL)', { command, toolCommand, vaultPath, wslVaultPath });
            return { command };
        }
        if (lowerApp === 'powershell' || lowerApp === 'powershell.exe') {
            const psWslPath = wslVaultPath.replace(/'/g, "''");
            const psCommand = toolCommand
                ? `start "" powershell -NoExit -Command "wsl.exe --cd '${psWslPath}' ${toolCommand}"`
                : `start "" powershell -NoExit -Command "wsl.exe --cd '${psWslPath}'"`;
            logger.log('Windows launch (powershell + WSL)', {
                command: psCommand,
                toolCommand,
                vaultPath,
                wslVaultPath
            });
            return { command: psCommand };
        }
        if (lowerApp === 'wt.exe' || lowerApp === 'wt') {
            const command = toolCommand
                ? `start "" wt.exe new-tab wsl.exe --cd "${escapeForCmdQuotedString(wslVaultPath)}" ${toolCommand}`
                : `start "" wt.exe new-tab wsl.exe --cd "${escapeForCmdQuotedString(wslVaultPath)}"`;
            logger.log('Windows launch (wt + WSL)', { command, toolCommand, vaultPath, wslVaultPath });
            return { command };
        }
        const command = `start "" cmd.exe /K "${wslCommand}"`;
        logger.log('Windows launch (generic + WSL fallback)', {
            command,
            app,
            toolCommand,
            vaultPath,
            wslVaultPath
        });
        return { command };
    }
    if (lowerApp === 'cmd.exe' || lowerApp === 'cmd') {
        const command = toolCommand
            ? `start "" cmd.exe /K "${cdCommand}${tool}"`
            : `start "" cmd.exe /K "${cdCommand}"`;
        logger.log('Windows launch (cmd.exe)', { command, toolCommand, vaultPath });
        return { command };
    }
    if (lowerApp === 'powershell' || lowerApp === 'powershell.exe') {
        if (!toolCommand) {
            const command = `start "" powershell -NoExit -Command "Set-Location '${vaultPath.replace(/'/g, "''")}';"`;
            logger.log('Windows launch (powershell)', { command, toolCommand, vaultPath });
            return { command };
        }
        const command = `start "" powershell -NoExit -Command "Set-Location '${vaultPath.replace(/'/g, "''")}'; ${toolCommand}"`;
        logger.log('Windows launch (powershell tool)', { command, toolCommand, vaultPath });
        return { command };
    }
    if (lowerApp === 'wt.exe' || lowerApp === 'wt') {
        const command = toolCommand
            ? `start "" wt.exe new-tab cmd /K "${cdCommand}${tool}"`
            : `start "" wt.exe new-tab cmd /K "${cdCommand}"`;
        logger.log('Windows launch (wt)', { command, toolCommand, vaultPath });
        return { command };
    }
    if (!toolCommand) {
        const command = `start "" "${app}"`;
        logger.log('Windows launch (generic simple)', { command, vaultPath });
        return { command };
    }
    const command = `start "" cmd.exe /K "${cdCommand}${tool}"`;
    logger.log('Windows launch (generic tool fallback)', { command, app, toolCommand, vaultPath });
    return { command };
};
const buildUnixLaunch = (terminalApp, toolCommand) => {
    const app = sanitizeTerminalApp(terminalApp);
    if (!app) {
        return null;
    }
    if (!toolCommand) {
        const command = `${app}`;
        logger.log('Unix launch (simple)', { command });
        return { command };
    }
    const shellCommand = `cd "$PWD"; ${toolCommand}; exec "$SHELL"`;
    if (app.includes('gnome-terminal')) {
        const command = `${app} -- bash -lc "${shellCommand}"`;
        logger.log('Unix launch (gnome-terminal)', { command, toolCommand });
        return { command };
    }
    if (app.includes('konsole')) {
        const command = `${app} -e bash -lc "${shellCommand}"`;
        logger.log('Unix launch (konsole)', { command, toolCommand });
        return { command };
    }
    const command = `${app} -e bash -lc "${shellCommand}"`;
    logger.log('Unix launch (generic tool)', { command, toolCommand });
    return { command };
};
const buildLaunchCommand = (terminalApp, vaultPath, toolCommand, options) => {
    if (!obsidian.Platform.isDesktopApp) {
        return null;
    }
    if (obsidian.Platform.isMacOS) {
        return buildMacLaunch(terminalApp, vaultPath, toolCommand);
    }
    if (obsidian.Platform.isWin) {
        return buildWindowsLaunch(terminalApp, vaultPath, toolCommand, options === null || options === void 0 ? void 0 : options.useWslOnWindows);
    }
    return buildUnixLaunch(terminalApp, toolCommand);
};

const defaultTerminalApp = () => {
    if (!obsidian.Platform.isDesktopApp) {
        return '';
    }
    if (obsidian.Platform.isMacOS) {
        return 'Terminal';
    }
    if (obsidian.Platform.isWin) {
        return 'cmd.exe';
    }
    if (obsidian.Platform.isLinux) {
        return 'x-terminal-emulator';
    }
    return '';
};
const getCurrentDesktopPlatform = () => {
    if (!obsidian.Platform.isDesktopApp) {
        return null;
    }
    if (obsidian.Platform.isMacOS) {
        return 'macos';
    }
    if (obsidian.Platform.isWin) {
        return 'win';
    }
    if (obsidian.Platform.isLinux) {
        return 'linux';
    }
    return null;
};
const buildDefaultTerminalAppSetting = () => {
    const platform = getCurrentDesktopPlatform();
    const app = defaultTerminalApp();
    if (!platform) {
        return {};
    }
    return { [platform]: app };
};
const DEFAULT_SETTINGS = {
    terminalApp: buildDefaultTerminalAppSetting(),
    enableClaude: false,
    enableCodex: false,
    enableCursor: false,
    enableGemini: false,
    enableOpencode: false,
    enableWslOnWindows: false,
    enableGitCommitPush: false,
    enableGitPull: false,
    defaultCommitMessage: 'update'
};
const isRecord = (value) => typeof value === 'object' && value !== null;
const normalizeTerminalAppSetting = (value, fallback) => {
    const platform = getCurrentDesktopPlatform();
    if (typeof value === 'string') {
        if (!platform) {
            return Object.assign({}, fallback);
        }
        return { [platform]: value.trim() };
    }
    if (isRecord(value)) {
        const next = {};
        if (typeof value.win === 'string') {
            next.win = value.win.trim();
        }
        if (typeof value.macos === 'string') {
            next.macos = value.macos.trim();
        }
        if (typeof value.linux === 'string') {
            next.linux = value.linux.trim();
        }
        return next;
    }
    return Object.assign({}, fallback);
};
const readBoolean = (value, fallback) => typeof value === 'boolean' ? value : fallback;
const normalizeSettings = (stored) => {
    const source = isRecord(stored) ? stored : {};
    return {
        terminalApp: normalizeTerminalAppSetting(source.terminalApp, DEFAULT_SETTINGS.terminalApp),
        enableClaude: readBoolean(source.enableClaude, DEFAULT_SETTINGS.enableClaude),
        enableCodex: readBoolean(source.enableCodex, DEFAULT_SETTINGS.enableCodex),
        enableCursor: readBoolean(source.enableCursor, DEFAULT_SETTINGS.enableCursor),
        enableGemini: readBoolean(source.enableGemini, DEFAULT_SETTINGS.enableGemini),
        enableOpencode: readBoolean(source.enableOpencode, DEFAULT_SETTINGS.enableOpencode),
        enableWslOnWindows: readBoolean(source.enableWslOnWindows, DEFAULT_SETTINGS.enableWslOnWindows),
        enableGitCommitPush: readBoolean(source.enableGitCommitPush, DEFAULT_SETTINGS.enableGitCommitPush),
        enableGitPull: readBoolean(source.enableGitPull, DEFAULT_SETTINGS.enableGitPull),
        defaultCommitMessage: typeof source.defaultCommitMessage === 'string'
            ? source.defaultCommitMessage
            : DEFAULT_SETTINGS.defaultCommitMessage
    };
};
const getCurrentTerminalApp = (terminalApp) => {
    var _a;
    const platform = getCurrentDesktopPlatform();
    if (!platform) {
        return '';
    }
    return (_a = terminalApp[platform]) !== null && _a !== void 0 ? _a : '';
};
const setCurrentTerminalApp = (terminalApp, value) => {
    const platform = getCurrentDesktopPlatform();
    if (!platform) {
        return Object.assign({}, terminalApp);
    }
    return Object.assign(Object.assign({}, terminalApp), { [platform]: value.trim() });
};

const optionalLaunchTargets = [
    {
        id: 'open-claude',
        commandName: 'Open in Claude Code',
        action: 'terminal',
        toolCommand: 'claude',
        settingKey: 'enableClaude',
        settingLabel: 'Claude Code'
    },
    {
        id: 'open-codex',
        commandName: 'Open in Codex cli',
        action: 'terminal',
        toolCommand: 'codex',
        settingKey: 'enableCodex',
        settingLabel: 'Codex cli'
    },
    {
        id: 'open-cursor',
        commandName: 'Open in Cursor cli',
        action: 'terminal',
        toolCommand: 'agent',
        settingKey: 'enableCursor',
        settingLabel: 'Cursor cli'
    },
    {
        id: 'open-gemini',
        commandName: 'Open in Gemini cli',
        action: 'terminal',
        toolCommand: 'gemini',
        settingKey: 'enableGemini',
        settingLabel: 'Gemini cli'
    },
    {
        id: 'open-opencode',
        commandName: 'Open in OpenCode',
        action: 'terminal',
        toolCommand: 'opencode',
        settingKey: 'enableOpencode',
        settingLabel: 'OpenCode'
    },
    {
        id: 'git-commit-push',
        commandName: 'Git: commit and push',
        action: 'git',
        gitAction: 'commit-push',
        settingKey: 'enableGitCommitPush',
        settingLabel: 'Git: commit and push'
    },
    {
        id: 'git-pull',
        commandName: 'Git: pull',
        action: 'git',
        gitAction: 'pull',
        settingKey: 'enableGitPull',
        settingLabel: 'Git: pull'
    }
];
const launchTargets = [
    {
        id: 'open-terminal',
        commandName: 'Open in terminal',
        action: 'terminal'
    },
    ...optionalLaunchTargets
];
const isTargetEnabled = (settings, target) => {
    if (!target.settingKey) {
        return true;
    }
    return settings[target.settingKey];
};

class OpenInTerminalSettingTab extends obsidian.PluginSettingTab {
    constructor(app, plugin) {
        super(app, plugin);
        this.plugin = plugin;
    }
    display() {
        const { containerEl } = this;
        containerEl.empty();
        new obsidian.Setting(containerEl).setName('Terminal integration').setHeading();
        new obsidian.Setting(containerEl)
            .setName('Terminal application name')
            .setDesc('Enter the command line app to launch, such as the default shell or a custom executable path.')
            .addText((text) => text
            .setPlaceholder(defaultTerminalApp())
            .setValue(getCurrentTerminalApp(this.plugin.settings.terminalApp))
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            this.plugin.settings.terminalApp = setCurrentTerminalApp(this.plugin.settings.terminalApp, value);
            yield this.plugin.saveSettings();
        })));
        if (obsidian.Platform.isWin) {
            new obsidian.Setting(containerEl)
                .setName('Use WSL for commands')
                .setDesc('Run commands inside WSL on Windows.')
                .addToggle((toggle) => toggle.setValue(this.plugin.settings.enableWslOnWindows).onChange((value) => __awaiter(this, void 0, void 0, function* () {
                this.plugin.settings.enableWslOnWindows = value;
                yield this.plugin.saveSettings();
            })));
        }
        new obsidian.Setting(containerEl).setName('Git commands').setHeading();
        new obsidian.Setting(containerEl)
            .setName('Default commit message')
            .setDesc('Used when running the commit and push command.')
            .addText((text) => text
            .setPlaceholder('Update')
            .setValue(this.plugin.settings.defaultCommitMessage)
            .onChange((value) => __awaiter(this, void 0, void 0, function* () {
            this.plugin.settings.defaultCommitMessage = value.trim() || 'update';
            yield this.plugin.saveSettings();
        })));
        new obsidian.Setting(containerEl)
            .setName('Enable Git: commit and push')
            .setDesc('Add a command to commit all changes and push to remote.')
            .addToggle((toggle) => toggle.setValue(this.plugin.settings.enableGitCommitPush).onChange((value) => __awaiter(this, void 0, void 0, function* () {
            this.plugin.settings.enableGitCommitPush = value;
            yield this.plugin.saveSettings();
        })));
        new obsidian.Setting(containerEl)
            .setName('Enable Git: pull')
            .setDesc('Add a command to pull changes from remote.')
            .addToggle((toggle) => toggle.setValue(this.plugin.settings.enableGitPull).onChange((value) => __awaiter(this, void 0, void 0, function* () {
            this.plugin.settings.enableGitPull = value;
            yield this.plugin.saveSettings();
        })));
        new obsidian.Setting(containerEl).setName('Command toggles').setHeading();
        for (const target of optionalLaunchTargets) {
            if (target.action !== 'terminal') {
                continue;
            }
            this.addToggleSetting(containerEl, target.settingLabel, () => this.plugin.settings[target.settingKey], (value) => __awaiter(this, void 0, void 0, function* () {
                this.plugin.settings[target.settingKey] = value;
                yield this.plugin.saveSettings();
            }));
        }
    }
    addToggleSetting(containerEl, label, getValue, setValue) {
        new obsidian.Setting(containerEl)
            .setName(`Enable ${label}`)
            .setDesc(`Add an 'Open in ${label}' command to the command palette.`)
            .addToggle((toggle) => toggle.setValue(getValue()).onChange((value) => __awaiter(this, void 0, void 0, function* () {
            yield setValue(value);
        })));
    }
}

const TEMP_SCRIPT_CLEANUP_DELAY_MS = 30000;
class OpenInTerminalPlugin extends obsidian.Plugin {
    constructor() {
        super(...arguments);
        this.registeredCommandIds = new Set();
        this.settings = Object.assign({}, DEFAULT_SETTINGS);
    }
    onload() {
        return __awaiter(this, void 0, void 0, function* () {
            yield this.loadSettings();
            this.addSettingTab(new OpenInTerminalSettingTab(this.app, this));
            this.refreshCommands();
        });
    }
    refreshCommands() {
        const commandManager = resolveCommandManager(this.app);
        if (commandManager) {
            for (const fullId of this.registeredCommandIds) {
                if (commandManager.findCommand(fullId)) {
                    commandManager.removeCommand(fullId);
                }
            }
        }
        this.registeredCommandIds.clear();
        for (const target of launchTargets) {
            if (!isTargetEnabled(this.settings, target)) {
                continue;
            }
            this.addCommand({
                id: target.id,
                name: target.commandName,
                callback: () => {
                    if (target.action === 'git') {
                        if (target.gitAction === 'commit-push') {
                            void this.runGitCommitPush();
                            return;
                        }
                        void this.runGitPull();
                        return;
                    }
                    this.runLaunchCommand(() => this.composeLaunchCommand(target.toolCommand), target.commandName);
                }
            });
            this.registeredCommandIds.add(`${this.manifest.id}:${target.id}`);
        }
    }
    composeLaunchCommand(toolCommand) {
        const adapter = this.app.vault.adapter;
        if (!(adapter instanceof obsidian.FileSystemAdapter)) {
            return null;
        }
        const vaultPath = adapter.getBasePath();
        const terminalApp = getCurrentTerminalApp(this.settings.terminalApp);
        const launchCommand = buildLaunchCommand(terminalApp, vaultPath, toolCommand, {
            useWslOnWindows: this.settings.enableWslOnWindows
        });
        logger.log('Compose launch command', {
            platform: getPlatformSummary(),
            terminalApp,
            toolCommand,
            vaultPath,
            launchCommand
        });
        return launchCommand;
    }
    runLaunchCommand(buildCommand, label) {
        const launchCommand = buildCommand();
        if (!launchCommand) {
            new obsidian.Notice(`Unable to run ${label}. Check the open in terminal settings for the terminal application name.`);
            return;
        }
        this.executeShellCommand(launchCommand, label);
    }
    executeShellCommand(launchCommand, label) {
        const adapter = this.app.vault.adapter;
        if (!(adapter instanceof obsidian.FileSystemAdapter)) {
            new obsidian.Notice('File system adapter not available. This plugin works only on desktop.');
            return;
        }
        const vaultPath = adapter.getBasePath();
        try {
            logger.log('Spawning command', { label, command: launchCommand.command, vaultPath });
            const child = child_process.spawn(launchCommand.command, {
                cwd: vaultPath,
                shell: true,
                detached: true,
                stdio: 'ignore'
            });
            child.on('error', (error) => {
                console.error(`[open-in-terminal] Failed to run '${launchCommand.command}':`, error);
                new obsidian.Notice(`Failed to run ${label}. Check the developer console for details.`);
            });
            child.unref();
            logger.log('Spawned command successfully', { label });
        }
        catch (error) {
            console.error(`[open-in-terminal] Unexpected error for '${launchCommand.command}':`, error);
            new obsidian.Notice(`Failed to run ${label}. Check the developer console for details.`);
        }
        finally {
            if (launchCommand.cleanup) {
                const cleanup = launchCommand.cleanup;
                setTimeout(() => {
                    try {
                        cleanup();
                    }
                    catch (error) {
                        console.warn('[open-in-terminal] Cleanup after command failed', error);
                    }
                }, TEMP_SCRIPT_CLEANUP_DELAY_MS);
            }
        }
    }
    loadSettings() {
        return __awaiter(this, void 0, void 0, function* () {
            this.settings = normalizeSettings(yield this.loadData());
        });
    }
    saveSettings() {
        return __awaiter(this, void 0, void 0, function* () {
            yield this.saveData(this.settings);
            this.refreshCommands();
        });
    }
    runGitCommitPush() {
        return __awaiter(this, void 0, void 0, function* () {
            const isGitRepo = yield this.checkGitRepo();
            if (!isGitRepo) {
                new obsidian.Notice('Not a Git repository');
                return;
            }
            const gitCommand = this.buildGitCommitPushCommand();
            this.runLaunchCommand(() => this.composeLaunchCommand(gitCommand), 'Git: commit and push');
        });
    }
    runGitPull() {
        return __awaiter(this, void 0, void 0, function* () {
            const isGitRepo = yield this.checkGitRepo();
            if (!isGitRepo) {
                new obsidian.Notice('Not a Git repository');
                return;
            }
            this.runLaunchCommand(() => this.composeLaunchCommand('git pull'), 'Git: pull');
        });
    }
    checkGitRepo() {
        return __awaiter(this, void 0, void 0, function* () {
            const adapter = this.app.vault.adapter;
            if (!(adapter instanceof obsidian.FileSystemAdapter)) {
                return false;
            }
            const vaultPath = adapter.getBasePath();
            return new Promise((resolve) => {
                const child = child_process.spawn('git', ['rev-parse', '--is-inside-work-tree'], {
                    cwd: vaultPath,
                    stdio: 'ignore'
                });
                child.on('close', (code) => resolve(code === 0));
                child.on('error', () => resolve(false));
            });
        });
    }
    buildGitCommitPushCommand() {
        const normalized = this.settings.defaultCommitMessage.replace(/[\r\n]+/g, ' ').trim() || 'update';
        const escaped = this.escapeCommitMessageForShell(normalized);
        return `git add . && git commit -m "${escaped}" && git push`;
    }
    escapeCommitMessageForShell(message) {
        if (obsidian.Platform.isWin) {
            return message
                .replace(/\^/g, '^^')
                .replace(/"/g, '""')
                .replace(/%/g, '%%')
                .replace(/!/g, '^^!');
        }
        return message
            .replace(/\\/g, '\\\\')
            .replace(/"/g, '\\"')
            .replace(/\$/g, '\\$')
            .replace(/`/g, '\\`');
    }
}

module.exports = OpenInTerminalPlugin;
//# sourceMappingURL=main.js.map

/* nosourcemap */