<template lang="pug">
  div.q-pa-md.rounded-borders
    h6.q-mb-md.q-mt-sm
      template(v-if="editing")
        | Edit Client
      template(v-else)
        | Add Client
    QForm(
      class="q-gutter-y-md column"
      ref="clientForm"
      @reset="onReset"
      @submit="onSubmit"
    )
      QInput(
        v-model="form.fullname"
        outlined
        label="Fullname *"
        hint="Enter client fullname"
        placeholder="mr.Rich"
        :rules="rules.fullname"
        lazy-rules
      )
      QInput(
        v-model="form.phone"
        ref="inputPhone"
        outlined
        label="Phone *"
        hint="Enter phone number"
        placeholder="79223334455"
        :rules="rules.phone"
        bottom-slots
        :error="!isValidPhone"
        :error-message="errors.phone[0]"
        lazy-rules
      )
      QInput(
        v-model="form.email"
        ref="inputEmail"
        outlined
        label="Email *"
        hint="Enter email"
        placeholder="email@example.com"
        :rules="rules.email"
        lazy-rules
        bottom-slots
        :error="!isValidEmail"
        :error-message="errors.email[0]"
        @blur="onBlurEmail"
      )
      div.row.q-pa-md.q-gutter-md.justify-end
        QBtn(label="Reset" type="reset" color="white" text-color="black")
        QBtn(label="Save" type="submit" color="primary" :disable="disabled")
</template>

<script>
import { QForm, QInput, QSelect } from 'quasar';
import Api from 'staffApi';

const MINIMUM_LENGTH = 5;
const ERRORS = {
  required: 'Field is required',
  blank: "Can't be blank.",
  only_numbers: 'Must be only numbers.',
  email: "Email is invalid.",
  minumim_length: (min = MINIMUM_LENGTH) => `Must be at least ${min} characters.`,
};

export default {
  components: {
    QForm,
    QInput,
  },

  props: {
    client: {
      type: Object,
    },
  },

  data() {
    return {
      form: {},
      errors: {
        fullname: [],
        phone: [],
        email: [],
      },
      rules: {
        fullname: [
          value => !!value || ERRORS.required,
          value => this.isLengthGreatThan(value, 5) || ERRORS.minumim_length(5),
        ],
        phone: [
          value => !!value || ERRORS.required,
          value => this.isNumber(value) || ERRORS.only_numbers,
        ],
        email: [
          value => !!value || ERRORS.required,
          value => this.isEmail(value) || ERRORS.email,
        ],
      },
      isValidUniqueness: false,
      editing: false,
    };
  },

  computed: {
    disabled() {
      return this.editing === false && this.isValidUniqueness === false;
    },

    isValidPhone() {
      return this.errors.phone.length === 0;
    },
    isValidEmail() {
      return this.errors.email.length === 0;
    },
  },

  created() {
    this.setDataForm(this.client);
  },

  methods: {
    onBlurEmail() {
      this.$refs.clientForm.validate().then(success => {
        if (success && this.editing === false) {
          this.verifyUniqueness();
        }
      });
    },

    onSubmit() {
      if (this.editing == true) {
        this.update();
      } else {
        this.create();
      }
    },

    onReset() {
      this.form = {};
      this.$refs.clientForm.resetValidation();
      this.isValidUniqueness = false;
    },

    onCreated(client) {
      this.$emit('client-created', client);
    },

    onUpdate(client) {
      this.$emit('client-updated', client);
    },

    verifyUniqueness() {
      this.isValidUniqueness = false;
      this.clearErrors();
      Api.clients.verifyUniqueness(this.form).then(data => {
        this.isValidUniqueness = true;
      }).catch(error => {
        this.fillErrors(error.response.data.errors);
      });
    },

    setDataForm(client) {
      if (!client) { return; }
      ['fullname', 'email', 'phone'].forEach(key => {
        this.form[key] = client[key];
      });
      this.editing = true;
    },

    create() {
      Api.clients.create(this.form).then(data => {
        this.onCreated(data);
        this.onReset();
      }).catch(error => {
        const errors = error.response.data.errors;
        this.fillErrors(errors);
      })
    },

    update() {
      const { id } = this.client;
      Api.clients.update(id, this.form).then(data => {
        this.onUpdate(data);
        this.onReset();
      }).catch(error => {
        const errors = error.response.data.errors;
        this.fillErrors(errors);
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

    fillErrors(errors) {
      Object.keys(errors).forEach(key => {
          this.errors[key] = errors[key];
      });
    },

    isNumber(value) {
      return Number.isInteger(Number(value));
    },

    isLengthGreatThan(value, min = MINIMUM_LENGTH) {
      return value && value.length >= min ? true : false;
    },

    isEmail(email) {
      const regexp = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return regexp.test(String(email).toLowerCase());
    },
  },
};
</script>
