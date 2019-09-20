<template lang="pug">
  div
    form(@submit.prevent="onSubmit")
      div.form-group
        label Full name
        div.text-danger(v-show="hasError('fullname')")
          span(v-for="error in errors.fullname")  {{ error }}
        input.form-control(type="text" v-model="form.fullname" @blur='validateFullname')
      div.form-group
        label Phone
        div.text-danger(v-show="hasError('phone')")
          span(v-for="error in errors.phone")  {{ error }}
        input.form-control(type="text" v-model="form.phone" @blur='validatePhone')
      div.form-group
        label Email
        div.text-danger(v-show="hasError('email')")
          span(v-for="error in errors.email")  {{ error }}
        input.form-control(type="text" v-model="form.email" @blur='validateEmail')
      hr.mb-2
      button.btn.btn-success.btn-block(type="submit" :disabled="disabled") Create
</template>

<script>
import Api from '../../api';

const MINIMUM_LENGTH = 5;
const ERRORS = {
  blank: "Can't be blank.",
  minumim_length: `Must be at least ${MINIMUM_LENGTH} characters.`,
  only_numbers: 'Must be only numbers.',
  email: "Email is invalid.",
};

export default {
  data() {
    return {
      form: {},
      errors: {
        fullname: [],
        phone: [],
        email: [],
      },
      isValid: false,
      isValidUniqueness: false,
    };
  },

  computed: {
    disabled() {
      return this.isValid === false && this.isValidUniqueness === false;
    },
  },

  watch: {
    form: {
      deep: true,
      handler() {
        this.formFilled();
      },
    },
    isValid(value) {
      if (value === true) {
        this.verifyUniqueness();
      }
    },
  },

  methods: {
    onSubmit() {
      Api.clients.create(this.form).then(data => {
        this.onCreated(data);
        this.resetForm();
      }).catch(error => {
        this.fillErrors(error.response.data.errors);
      })
    },

    onCreated(client) {
      this.$emit('client-created', client);
    },

    resetForm() {
      this.isValid = false;
      this.isValidUniqueness = false;
      this.form = {};
    },

    formFilled() {
      const filled = Object.keys(this.form).every(key => this.form[key] && this.form[key].length > 0);
      if (filled) {
        this.validate();
      }
    },

    validate() {
      this.clearErrors();
      this.validateFullname();
      this.validatePhone();
      this.validateEmail();
      if (this.hasErrors() == false) {
        this.isValid = true;
      };
    },

    verifyUniqueness() {
      this.isValidUniqueness = false;
      Api.clients.verifyUniqueness(this.form).then(data => {
        this.isValidUniqueness = true;
      }).catch(error => {
        this.isValid = false;
        this.fillErrors(error.response.data.errors);
      });
    },

    hasErrors() {
      return Object.keys(this.errors).some(key => {
        return this.errors[key].length > 0;
      });
    },

    hasError(name) {
      return this.errors[name].length > 0;
    },

    clearErrors() {
      Object.keys(this.errors).forEach(key => this.errors[key] = []);
    },

    validateFullname() {
      const { fullname } = this.form;
      this.errors.fullname = [];
      if (this.isBlank(fullname)) {
        this.errors.fullname.push(ERRORS.blank);
      } else if (this.isLengthLessThan(fullname, MINIMUM_LENGTH)) {
        this.errors.fullname.push(ERRORS.minumim_length);
      }
     },

    validatePhone() {
      const { phone } = this.form;
      this.errors.phone = [];
      if (this.isBlank(phone)) {
        this.errors.phone.push(ERRORS.blank);
      } else if (Number.isInteger(Number(phone)) === false) {
        this.errors.phone.push(ERRORS.only_numbers);
      }
    },

    validateEmail() {
      const { email } = this.form;
      this.errors.email = [];
      if (this.isEmail(email) === false) {
        this.errors.email.push(ERRORS.email);
      }
    },

    fillErrors(errors) {
      Object.keys(errors).forEach(key => {
          this.errors[key] = errors[key];
      });
    },

    isBlank(value) {
      return value ? false : true;
    },

    isLengthLessThan(value, min = MINIMUM_LENGTH) {
      return value && value.length >= min ? false : true;
    },

    isEmail(email) {
      const regexp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return regexp.test(String(email).toLowerCase());
    }
  },
};
</script>
