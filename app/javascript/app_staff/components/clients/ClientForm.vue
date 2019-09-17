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
      button.btn.btn-success.btn-block(type="submit") Create
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
      form: {
        fullname: null,
        phone: null,
        email: null,
      },
      isValidate: false,
      errors: {
        fullname: [],
        phone: [],
        email: [],
      }
    };
  },

  methods: {
    onSubmit() {
      if (this.isFormValid() === false) {
        return false;
      }
      Api.clients.create(this.form).then(data => {
        this.onCreated(data);
        this.resetForm();
      }).catch(error => {
        const errors = error.response.data.errors;
        Object.keys(errors).forEach(key => {
          this.errors[key] = errors[key];
        })
      })
    },

    onCreated(client) {
      this.$emit('client-created', client);
    },

    resetForm() {
      Object.keys(this.form).forEach(key => this.form[key] = null);
    },

    isFormValid() {
      this.clearErrors();
      this.validateFullname();
      this.validatePhone();
      this.validateEmail();
      return this.hasErrors() ? false : true;
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

<style lang="scss" scoped>

</style>
