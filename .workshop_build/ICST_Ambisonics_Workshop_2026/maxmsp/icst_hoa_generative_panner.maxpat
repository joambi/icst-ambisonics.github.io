{
	"patcher" : {
		"fileversion" : 1,
		"appversion" : {
			"major" : 8,
			"minor" : 6,
			"revision" : 4,
			"architecture" : "x64",
			"modernui" : 1
		},
		"rect" : [ 50.0, 50.0, 980.0, 700.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"boxes" : [
			{
				"box" : {
					"id" : "obj-title",
					"maxclass" : "comment",
					"text" : "ICST HOA — Generative 3-Source Panner",
					"patching_rect" : [ 15.0, 12.0, 520.0, 22.0 ],
					"fontsize" : 16.0,
					"fontface" : 1,
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},
			{
				"box" : {
					"id" : "obj-info",
					"maxclass" : "comment",
					"text" : "Requires: ICST Ambisonics Externals  ·  Max Package Manager → 'ICST Ambisonics Tools'  ·  ambisonics.ch",
					"patching_rect" : [ 15.0, 36.0, 680.0, 18.0 ],
					"fontsize" : 11.0,
					"textcolor" : [ 0.45, 0.55, 0.65, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},
			{
				"box" : {
					"id" : "obj-info2",
					"maxclass" : "comment",
					"text" : "Signalfluss:  3× Quellen  →  3× ambipanning~ (HOA 3rd, 16ch)  →  mc.+~ Summe  →  ambidecode~ (Binaural)  →  ezdac~",
					"patching_rect" : [ 15.0, 55.0, 780.0, 18.0 ],
					"fontsize" : 11.0,
					"textcolor" : [ 0.45, 0.55, 0.65, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},

			{
				"box" : {
					"id" : "obj-toggle",
					"maxclass" : "toggle",
					"patching_rect" : [ 895.0, 80.0, 40.0, 40.0 ],
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "int" ]
				}
			},
			{
				"box" : {
					"id" : "obj-toggle-label",
					"maxclass" : "comment",
					"text" : "▶ ON/OFF\n(startet alle\nMetros)",
					"patching_rect" : [ 895.0, 124.0, 75.0, 48.0 ],
					"fontsize" : 10.0,
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},

			{
				"box" : {
					"id" : "obj-lbl-s1",
					"maxclass" : "comment",
					"text" : "── Source 1: 220 Hz Sine",
					"patching_rect" : [ 15.0, 80.0, 195.0, 18.0 ],
					"fontsize" : 11.5,
					"fontface" : 1,
					"textcolor" : [ 0.29, 0.62, 0.85, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},
			{
				"box" : {
					"id" : "obj-osc1",
					"maxclass" : "newobj",
					"text" : "cycle~ 220",
					"patching_rect" : [ 15.0, 102.0, 85.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-osc1b",
					"maxclass" : "newobj",
					"text" : "cycle~ 221",
					"patching_rect" : [ 108.0, 102.0, 80.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-add1",
					"maxclass" : "newobj",
					"text" : "+~ ",
					"patching_rect" : [ 15.0, 132.0, 45.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-gain1",
					"maxclass" : "newobj",
					"text" : "*~ 0.3",
					"patching_rect" : [ 15.0, 162.0, 55.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-pan1",
					"maxclass" : "newobj",
					"text" : "ambipanning~ 3",
					"patching_rect" : [ 15.0, 200.0, 115.0, 22.0 ],
					"numinlets" : 3,
					"numoutlets" : 16,
					"outlettype" : [ "signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-lbl-pan1",
					"maxclass" : "comment",
					"text" : "az(°) el(°)",
					"patching_rect" : [ 138.0, 204.0, 65.0, 18.0 ],
					"fontsize" : 10.0,
					"textcolor" : [ 0.55, 0.55, 0.55, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},

			{
				"box" : {
					"id" : "obj-lbl-s2",
					"maxclass" : "comment",
					"text" : "── Source 2: 330 Hz Sine",
					"patching_rect" : [ 295.0, 80.0, 195.0, 18.0 ],
					"fontsize" : 11.5,
					"fontface" : 1,
					"textcolor" : [ 0.29, 0.62, 0.85, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},
			{
				"box" : {
					"id" : "obj-osc2",
					"maxclass" : "newobj",
					"text" : "cycle~ 330",
					"patching_rect" : [ 295.0, 102.0, 85.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-gain2",
					"maxclass" : "newobj",
					"text" : "*~ 0.25",
					"patching_rect" : [ 295.0, 132.0, 60.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-pan2",
					"maxclass" : "newobj",
					"text" : "ambipanning~ 3",
					"patching_rect" : [ 295.0, 200.0, 115.0, 22.0 ],
					"numinlets" : 3,
					"numoutlets" : 16,
					"outlettype" : [ "signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal" ]
				}
			},

			{
				"box" : {
					"id" : "obj-lbl-s3",
					"maxclass" : "comment",
					"text" : "── Source 3: Filtered Noise",
					"patching_rect" : [ 565.0, 80.0, 210.0, 18.0 ],
					"fontsize" : 11.5,
					"fontface" : 1,
					"textcolor" : [ 0.29, 0.62, 0.85, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},
			{
				"box" : {
					"id" : "obj-noise",
					"maxclass" : "newobj",
					"text" : "noise~",
					"patching_rect" : [ 565.0, 102.0, 55.0, 22.0 ],
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-lores",
					"maxclass" : "newobj",
					"text" : "lores~ 500 0.7",
					"patching_rect" : [ 565.0, 132.0, 105.0, 22.0 ],
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-gain3",
					"maxclass" : "newobj",
					"text" : "*~ 0.12",
					"patching_rect" : [ 565.0, 162.0, 60.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-pan3",
					"maxclass" : "newobj",
					"text" : "ambipanning~ 3",
					"patching_rect" : [ 565.0, 200.0, 115.0, 22.0 ],
					"numinlets" : 3,
					"numoutlets" : 16,
					"outlettype" : [ "signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal","signal" ]
				}
			},

			{
				"box" : {
					"id" : "obj-lbl-gen",
					"maxclass" : "comment",
					"text" : "── Generative Azimut-Bewegung  (metro → drunk → flonum → az-Inlet von ambipanning~)",
					"patching_rect" : [ 15.0, 248.0, 580.0, 18.0 ],
					"fontsize" : 11.5,
					"fontface" : 1,
					"textcolor" : [ 0.94, 0.71, 0.2, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},

			{
				"box" : {
					"id" : "obj-metro1",
					"maxclass" : "newobj",
					"text" : "metro 80",
					"patching_rect" : [ 15.0, 270.0, 70.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}
			},
			{
				"box" : {
					"id" : "obj-drunk1",
					"maxclass" : "newobj",
					"text" : "drunk 360 20",
					"patching_rect" : [ 15.0, 300.0, 90.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ]
				}
			},
			{
				"box" : {
					"id" : "obj-fn-az1",
					"maxclass" : "flonum",
					"patching_rect" : [ 15.0, 330.0, 70.0, 22.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ]
				}
			},
			{
				"box" : {
					"id" : "obj-el1",
					"maxclass" : "flonum",
					"patching_rect" : [ 95.0, 330.0, 55.0, 22.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"varname" : "el1"
				}
			},
			{
				"box" : {
					"id" : "obj-lbl-el1",
					"maxclass" : "comment",
					"text" : "El S1\n(−90..90)",
					"patching_rect" : [ 158.0, 326.0, 58.0, 30.0 ],
					"fontsize" : 10.0,
					"textcolor" : [ 0.4, 0.75, 0.4, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},

			{
				"box" : {
					"id" : "obj-metro2",
					"maxclass" : "newobj",
					"text" : "metro 150",
					"patching_rect" : [ 295.0, 270.0, 72.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}
			},
			{
				"box" : {
					"id" : "obj-drunk2",
					"maxclass" : "newobj",
					"text" : "drunk 360 40",
					"patching_rect" : [ 295.0, 300.0, 90.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ]
				}
			},
			{
				"box" : {
					"id" : "obj-fn-az2",
					"maxclass" : "flonum",
					"patching_rect" : [ 295.0, 330.0, 70.0, 22.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ]
				}
			},
			{
				"box" : {
					"id" : "obj-el2",
					"maxclass" : "flonum",
					"patching_rect" : [ 375.0, 330.0, 55.0, 22.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ]
				}
			},
			{
				"box" : {
					"id" : "obj-lbl-el2",
					"maxclass" : "comment",
					"text" : "El S2",
					"patching_rect" : [ 438.0, 333.0, 40.0, 18.0 ],
					"fontsize" : 10.0,
					"textcolor" : [ 0.4, 0.75, 0.4, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},

			{
				"box" : {
					"id" : "obj-metro3",
					"maxclass" : "newobj",
					"text" : "metro 220",
					"patching_rect" : [ 565.0, 270.0, 72.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}
			},
			{
				"box" : {
					"id" : "obj-drunk3",
					"maxclass" : "newobj",
					"text" : "drunk 360 12",
					"patching_rect" : [ 565.0, 300.0, 90.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ]
				}
			},
			{
				"box" : {
					"id" : "obj-fn-az3",
					"maxclass" : "flonum",
					"patching_rect" : [ 565.0, 330.0, 70.0, 22.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ]
				}
			},
			{
				"box" : {
					"id" : "obj-el3",
					"maxclass" : "flonum",
					"patching_rect" : [ 645.0, 330.0, 55.0, 22.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ]
				}
			},
			{
				"box" : {
					"id" : "obj-lbl-el3",
					"maxclass" : "comment",
					"text" : "El S3",
					"patching_rect" : [ 708.0, 333.0, 40.0, 18.0 ],
					"fontsize" : 10.0,
					"textcolor" : [ 0.4, 0.75, 0.4, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},

			{
				"box" : {
					"id" : "obj-lbl-sum",
					"maxclass" : "comment",
					"text" : "── HOA-Summe (16ch) + Binaural Decode",
					"patching_rect" : [ 15.0, 390.0, 320.0, 18.0 ],
					"fontsize" : 11.5,
					"fontface" : 1,
					"textcolor" : [ 0.55, 0.85, 0.55, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},
			{
				"box" : {
					"id" : "obj-sum-note",
					"maxclass" : "comment",
					"text" : "Hinweis: ambipanning~ gibt 16 HOA-Kanäle als MC-Signal aus.\nFür 3 Quellen: mc.+~ summiert die drei 16ch-MC-Signale vor dem Decoder.\nAlternativ: ambiencode~ für Multi-Source-Encoding in einer Instanz verwenden.",
					"patching_rect" : [ 15.0, 410.0, 560.0, 46.0 ],
					"fontsize" : 10.5,
					"textcolor" : [ 0.6, 0.6, 0.6, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},

			{
				"box" : {
					"id" : "obj-mcsum",
					"maxclass" : "newobj",
					"text" : "mc.+~",
					"patching_rect" : [ 15.0, 468.0, 55.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "multichannelsignal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-mcsum2",
					"maxclass" : "newobj",
					"text" : "mc.+~",
					"patching_rect" : [ 15.0, 498.0, 55.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "multichannelsignal" ]
				}
			},

			{
				"box" : {
					"id" : "obj-decode",
					"maxclass" : "newobj",
					"text" : "ambidecode~ binaural",
					"patching_rect" : [ 15.0, 538.0, 115.0, 22.0 ],
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "signal", "signal" ]
				}
			},
			{
				"box" : {
					"id" : "obj-decode-lbl",
					"maxclass" : "comment",
					"text" : "0 = Binaural (HRTF)\nPressure-Velocity-Modus:\nam. evtl. 'binaural' als Argument",
					"patching_rect" : [ 170.0, 530.0, 260.0, 58.0 ],
					"fontsize" : 10.0,
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			},

			{
				"box" : {
					"id" : "obj-dac",
					"maxclass" : "newobj",
					"text" : "ezdac~",
					"patching_rect" : [ 15.0, 590.0, 60.0, 22.0 ],
					"numinlets" : 2,
					"numoutlets" : 0
				}
			},
			{
				"box" : {
					"id" : "obj-dac-lbl",
					"maxclass" : "comment",
					"text" : "Stereo Binaural Out  ·  BEIDE Outlets → ezdac~\nOutlet 0 → ezdac~ Inlet 0 = Links (L)\nOutlet 1 → ezdac~ Inlet 1 = Rechts (R)",
					"patching_rect" : [ 85.0, 590.0, 170.0, 30.0 ],
					"fontsize" : 10.0,
					"textcolor" : [ 0.5, 0.5, 0.5, 1.0 ],
					"numinlets" : 1,
					"numoutlets" : 0
				}
			}
		],
		"lines" : [
			{ "patchline" : { "source" : [ "obj-osc1",  0 ], "destination" : [ "obj-add1",  0 ] } },
			{ "patchline" : { "source" : [ "obj-osc1b", 0 ], "destination" : [ "obj-add1",  1 ] } },
			{ "patchline" : { "source" : [ "obj-add1",  0 ], "destination" : [ "obj-gain1", 0 ] } },
			{ "patchline" : { "source" : [ "obj-gain1", 0 ], "destination" : [ "obj-pan1",  0 ] } },

			{ "patchline" : { "source" : [ "obj-osc2",  0 ], "destination" : [ "obj-gain2", 0 ] } },
			{ "patchline" : { "source" : [ "obj-gain2", 0 ], "destination" : [ "obj-pan2",  0 ] } },

			{ "patchline" : { "source" : [ "obj-noise",  0 ], "destination" : [ "obj-lores", 0 ] } },
			{ "patchline" : { "source" : [ "obj-lores",  0 ], "destination" : [ "obj-gain3", 0 ] } },
			{ "patchline" : { "source" : [ "obj-gain3",  0 ], "destination" : [ "obj-pan3",  0 ] } },

			{ "patchline" : { "source" : [ "obj-metro1", 0 ], "destination" : [ "obj-drunk1", 0 ] } },
			{ "patchline" : { "source" : [ "obj-drunk1", 0 ], "destination" : [ "obj-fn-az1", 0 ] } },
			{ "patchline" : { "source" : [ "obj-fn-az1", 0 ], "destination" : [ "obj-pan1",   1 ] } },
			{ "patchline" : { "source" : [ "obj-el1",    0 ], "destination" : [ "obj-pan1",   2 ] } },

			{ "patchline" : { "source" : [ "obj-metro2", 0 ], "destination" : [ "obj-drunk2", 0 ] } },
			{ "patchline" : { "source" : [ "obj-drunk2", 0 ], "destination" : [ "obj-fn-az2", 0 ] } },
			{ "patchline" : { "source" : [ "obj-fn-az2", 0 ], "destination" : [ "obj-pan2",   1 ] } },
			{ "patchline" : { "source" : [ "obj-el2",    0 ], "destination" : [ "obj-pan2",   2 ] } },

			{ "patchline" : { "source" : [ "obj-metro3", 0 ], "destination" : [ "obj-drunk3", 0 ] } },
			{ "patchline" : { "source" : [ "obj-drunk3", 0 ], "destination" : [ "obj-fn-az3", 0 ] } },
			{ "patchline" : { "source" : [ "obj-fn-az3", 0 ], "destination" : [ "obj-pan3",   1 ] } },
			{ "patchline" : { "source" : [ "obj-el3",    0 ], "destination" : [ "obj-pan3",   2 ] } },

			{ "patchline" : { "source" : [ "obj-toggle", 0 ], "destination" : [ "obj-metro1", 0 ] } },
			{ "patchline" : { "source" : [ "obj-toggle", 0 ], "destination" : [ "obj-metro2", 0 ] } },
			{ "patchline" : { "source" : [ "obj-toggle", 0 ], "destination" : [ "obj-metro3", 0 ] } },

			{ "patchline" : { "source" : [ "obj-pan1",   0 ], "destination" : [ "obj-mcsum",  0 ] } },
			{ "patchline" : { "source" : [ "obj-pan2",   0 ], "destination" : [ "obj-mcsum",  1 ] } },
			{ "patchline" : { "source" : [ "obj-mcsum",  0 ], "destination" : [ "obj-mcsum2", 0 ] } },
			{ "patchline" : { "source" : [ "obj-pan3",   0 ], "destination" : [ "obj-mcsum2", 1 ] } },

			{ "patchline" : { "source" : [ "obj-mcsum2", 0 ], "destination" : [ "obj-decode", 0 ] } },

			{ "patchline" : { "source" : [ "obj-decode", 0 ], "destination" : [ "obj-dac",    0 ] } },
			{ "patchline" : { "source" : [ "obj-decode", 1 ], "destination" : [ "obj-dac",    1 ] } }
		],
		"dependency_cache" : []
	}
}
