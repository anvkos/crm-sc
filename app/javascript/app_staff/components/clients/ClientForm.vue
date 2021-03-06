<template lang="pug">
  div.q-pa-md.rounded-borders
    h6.q-mb-md.q-mt-sm
      | {{ editing ? 'Client' : 'Add Client' }}
    q-form(
      class="q-gutter-y-md column"
      ref="clientForm"
      @reset="onReset"
      @submit="onSubmit"
    )
      q-input(
        v-model="form.fullname"
        outlined
        label="Fullname *"
        hint="Enter client fullname"
        placeholder="mr.Rich"
        :rules="rules.fullname"
        lazy-rules
      )
      q-input(
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
      q-input(
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
        q-btn(label="Reset" type="reset" color="white" text-color="black")
        q-btn(label="Save" type="submit" color="primary" :disable="disabled")
</template>

<script>
import { QForm, QInput, QSelect } from 'quasar';
import { validator, validatorErrors, VALIDATION_ERRORS } from 'staffApp/mixins/validator';
import Api from 'staffApi';

export default {
  components: {
    QForm,
    QInput,
  },

  mixins: [validator, validatorErrors],

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
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isLengthGreatThan(value, 5) || VALIDATION_ERRORS.minumim_length(5),
        ],
        phone: [
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isNumber(value) || VALIDATION_ERRORS.only_numbers,
        ],
        email: [
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isEmail(value) || VALIDATION_ERRORS.email,
        ],
      },
      isValidUniqueness: false,
    };
  },

  computed: {
    disabled() {
      return this.editing === false && this.isValidUniqueness === false;
    },

    isValidPhone() {
      return this.errors.phone.length === 0;
    },

    editing() {
      return !!this.client;
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
  },
};
</script>
