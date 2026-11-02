document.addEventListener('DOMContentLoaded', () => {
  const navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);
  const nav = document.querySelector('nav.nav');

  // Dropdown submenus: real buttons with aria-expanded (keyboard and screen reader accessible)
  const dropdowns = Array.prototype.slice.call(document.querySelectorAll('.optionswitch'), 0);
  const setOpen = (dropdown, open) => {
    const button = dropdown.querySelector('.optionswitch__label');
    dropdown.classList.toggle('optionswitch--open', open);
    if (button) button.setAttribute('aria-expanded', String(open));
  };
  const closeAll = (except) => {
    dropdowns.forEach((d) => {
      if (d !== except) setOpen(d, false);
    });
  };
  dropdowns.forEach((dropdown) => {
    const button = dropdown.querySelector('.optionswitch__label');
    if (!button) return;
    button.addEventListener('click', () => {
      const open = !dropdown.classList.contains('optionswitch--open');
      closeAll(dropdown);
      setOpen(dropdown, open);
    });
    dropdown.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && dropdown.classList.contains('optionswitch--open')) {
        setOpen(dropdown, false);
        button.focus();
      }
    });
  });
  document.addEventListener('click', (e) => {
    if (!e.target.closest('.optionswitch')) closeAll(null);
  });

  if (navbarBurgers.length < 1 || !nav) return;
  navbarBurgers.forEach((navbarBurger) => {
    navbarBurger.addEventListener('click', () => {
      const active = navbarBurger.classList.toggle('nav--active');
      nav.classList.toggle('nav--active', active);
      navbarBurger.setAttribute('aria-expanded', String(active));
    });
  });
});
