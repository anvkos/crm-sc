<template lang="pug">
    div.q-pa-md.rounded-borders
      h6.q-mb-md.q-mt-sm Add Staff
      QForm(
        class="q-gutter-y-md column"
        ref="staffForm"
        @reset="onReset"
        @submit="onSubmit"
      )
        QInput(
          v-model="form.fullname"
          outlined
          label="Fullname *"
          hint="Enter staff fullname"
          placeholder="Ivanov Ivan"
          :rules="rules.fullname"
          lazy-rules
        )
        QInput(
          v-model="form.email"
          outlined
          label="Email *"
          hint="Enter email"
          placeholder="email@example.com"
          :rules="rules.email"
          lazy-rules
          bottom-slots
          :error="!isValidEmail"
          :error-message="errors.email[0]"
        )
        QInput(
          v-model="form.password"
          type="password"
          outlined
          label="Password *"
          hint="Enter password"
          placeholder="secret"
          :rules="rules.password"
          lazy-rules
          bottom-slots
          :error="!isValidPassword"
          :error-message="errors.password[0]"
        )
        div.row.q-pa-md.q-gutter-md.justify-end
          QBtn(label="Reset" type="reset" color="white" text-color="black")
          QBtn(label="Save" type="submit" color="primary")
</template>

<script>
import { QForm, QInput } from 'quasar';
import Api from 'staffApi';
import { validator, validatorErrors, VALIDATION_ERRORS } from 'staffApp/mixins/validator';

export default {
  components: {
    QForm,
    QInput,
  },

  mixins: [validator, validatorErrors],

  data() {
    return {
      form: {},
      rules: {
        fullname: [
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isLengthGreatThan(value, 5) || VALIDATION_ERRORS.minumim_length(5),
        ],
        email: [
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isEmail(value) || VALIDATION_ERRORS.email,
        ],
        password: [
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isLengthGreatThan(value, 6) || VALIDATION_ERRORS.minumim_length(6),
        ],
      }
    };
  },

  methods: {
    onSubmit() {
      Api.staffs.create(this.form).then(data => {
        this.onCreated(data);
        this.onReset();
      }).catch(error => {
        const errors = error.response.data.errors;
        this.fillErrors(errors);
      })
    },

    onReset() {
      this.form = {};
      this.$refs.staffForm.resetValidation();
      this.clearErrors();
    },

    onCreated(staff) {
      this.$emit('staff-created', staff);
    },
  },
};
</script>