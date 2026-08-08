// Login form JavaScript for Keycloak Ant Design theme

// Password visibility toggle functionality
document.addEventListener('DOMContentLoaded', function() {
  var toggleButtons = document.querySelectorAll('.kc-password-toggle');

  toggleButtons.forEach(function(button) {
    button.addEventListener('click', function() {
      var wrapper = this.closest('.kc-password-wrapper');
      var input = wrapper.querySelector('input');

      if (input.type === 'password') {
        input.type = 'text';
        this.classList.add('toggled');
        this.setAttribute('aria-label', 'Hide password');
      } else {
        input.type = 'password';
        this.classList.remove('toggled');
        this.setAttribute('aria-label', 'Show password');
      }
    });
  });

  // Fix duplicated locale labels in the language selector.
  // Keycloak generates labels like "中文 (简体) (中文 (简体))" where the
  // display name and native name are identical. This regex detects the
  // "X (X)" pattern and reduces it to "X". Non-duplicated labels like
  // "英语 (English)" are left unchanged.
  var localeSelect = document.getElementById('kc-locale-select');
  if (localeSelect) {
    Array.from(localeSelect.options).forEach(function(option) {
      var match = option.textContent.match(/^(.+) \(\1\)$/);
      if (match) {
        option.textContent = match[1];
      }
    });
  }
});
