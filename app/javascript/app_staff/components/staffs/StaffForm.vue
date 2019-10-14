<template lang="pug">
    div.q-pa-md.rounded-borders
      h6.q-mb-md.q-mt-sm
        | {{ editing ? 'Staff' : 'Add Staff'}}
      q-form(
        class="q-gutter-y-md column"
        ref="staffForm"
        @reset="onReset"
        @submit="onSubmit"
      )
        q-input(
          v-model="form.fullname"
          outlined
          label="Fullname *"
          hint="Enter staff fullname"
          placeholder="Ivanov Ivan"
          :rules="rules.fullname"
          lazy-rules
        )
        q-input(
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
        q-input(
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
          q-btn(label="Reset" type="reset" color="white" text-color="black")
          q-btn(label="Save" type="submit" color="primary")
</template>

<script>
import { QForm, QInput } from 'quasar';
import { mapActions } from 'vuex';
import Api from 'staffApi';
import { validator, validatorErrors, VALIDATION_ERRORS } from 'staffApp/mixins/validator';

export default {
  components: {
    QForm,
    QInput,
  },

  mixins: [validator, validatorErrors],

  props: {
    staff: {
      type: Object,
    },
  },

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
      },
    };
  },

  computed: {
    editing() {
      return !!this.staff;
    },
  },

  created() {
    this.setDataForm(this.staff);
  },

  methods: {
    ...mapActions({
      createStaff: 'staffs/create',
      updateStaff: 'staffs/update',
    }),

    onSubmit() {
      if (this.editing == true) {
        this.update();
      } else {
        this.create();
      }
    },

    onReset() {
      this.form = {};
      this.$refs.staffForm.resetValidation();
      this.clearErrors();
    },

    onUpdate() {
      this.$emit('staff-updated');
    },

    setDataForm(staff) {
      if (!staff) { return; }
      ['fullname', 'email'].forEach(key => {
        this.form[key] = staff[key];
      });
    },

    create() {
      this.createStaff(this.form).then(() => {
        this.onReset();
      }).catch(error => {
        const errors = error.response.data.errors;
        this.fillErrors(errors);
      });
    },

    update() {
      this.updateStaff({ id: this.staff.id, params: this.form }).then(() => {
        this.onReset();
        this.onUpdate();
      }).catch(error => {
        const errors = error.response.data.errors;
        this.fillErrors(errors);
      });
    },
  },
};
</script>
