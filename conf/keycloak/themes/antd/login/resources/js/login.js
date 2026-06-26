// Login form JavaScript for Keycloak Ant Design theme

// Password visibility toggle functionality
document.addEventListener('DOMContentLoaded', function() {
  const toggleButtons = document.querySelectorAll('.kc-password-toggle');

  toggleButtons.forEach(function(button) {
    button.addEventListener('click', function() {
      const wrapper = this.closest('.kc-password-wrapper');
      const input = wrapper.querySelector('input');

      if (input.type === 'password') {
        // Password is hidden, show it
        input.type = 'text';
        this.classList.add('toggled');
        this.setAttribute('aria-label', 'Hide password');
      } else {
        // Password is visible, hide it
        input.type = 'password';
        this.classList.remove('toggled');
        this.setAttribute('aria-label', 'Show password');
      }
    });
  });
});
