const MINIMUM_LENGTH = 5;

export const VALIDATION_ERRORS = {
  required: 'Field is required',
  blank: "Can't be blank.",
  only_numbers: 'Must be only numbers.',
  email: "Email is invalid.",
  minumim_length: (min = MINIMUM_LENGTH) => `Must be at least ${min} characters.`,
};

export const validatorErrors = {
  data() {
    return {
      errors: {
        fullname: [],
        email: [],
        password: [],
      },
    };
  },

  computed: {
    isValidEmail() {
      return this.errors.email.length === 0;
    },

    isValidPassword() {
      return this.errors.password.length === 0;
    },
  },

  methods: {
    fillErrors(errors) {
      Object.keys(errors).forEach(key => {
          this.errors[key] = errors[key];
      });
    },

    clearErrors() {
      Object.keys(this.errors).forEach(key => this.errors[key] = []);
    },
  },
};

export const validator = {
  methods: {
    isNumber(value) {
      return Number.isInteger(Number(value));
    },

    isLengthGreatThan(value, min = MINIMUM_LENGTH) {
      return value && value.length >= min ? true : false;
    },

    isEmail(value) {
      const regexp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return regexp.test(String(value).toLowerCase());
    }
  },
}

export default validator;
