<template lang="pug">
  div.q-pa-md.rounded-borders
    h6.q-mb-md.q-mt-sm Add Organization
    q-form(
      class="q-gutter-y-md column"
      ref="organizationForm"
      @reset="onReset"
      @submit="onSubmit"
    )
      q-input(
        v-model="form.name"
        outlined
        label="Name *"
        hint="Enter organization name"
        placeholder="Company Ltd."
        :rules="rules.name"
        lazy-rules
      )
      q-select(
        v-model="form.kind"
        outlined
        :options="kinds"
        label="Type"
        hint="Select organization type"
        lazy-rules
        :rules="rules.kind"
      )
      q-input(
        v-model="form.inn"
        outlined
        label="INN *"
        hint="Enter organization INN"
        :rules="rules.inn"
        lazy-rules
      )
      q-input(
        v-model="form.ogrn"
        outlined
        label="OGRN *"
        hint="Enter organization OGRN"
        lazy-rules
        :rules="rules.ogrn"
      )
      div.row.q-pa-md.q-gutter-md.justify-end
        q-btn(label="Reset" type="reset" color="white" text-color="black")
        q-btn(label="Save" type="submit" color="secondary")

</template>

<script>
import Api from 'staffApi';
import { QForm, QInput, QSelect } from 'quasar';

const MINIMUM_LENGTH = 5;
const ERRORS = {
  required: 'Field is required',
  select: 'Please select type of organization',
  only_numbers: 'Must be only numbers.',
  minumim_length: (min = MINIMUM_LENGTH) => `Must be at least ${min} characters.`,
};

const ORGANIZATION_KINDS = ['ИП', 'ЮЛ'];

export default {
  components: {
    QForm,
    QInput,
    QSelect,
  },

  data() {
    return {
      form: {},
      kinds: ORGANIZATION_KINDS,
      rules: {
        name: [
          value => !!value || ERRORS.required,
          value => this.isLengthGreatThan(value, 5) || ERRORS.minumim_length(5)
        ],
        kind: [value => !!value || ERRORS.select],
        inn: [
          value => !!value || ERRORS.required,
          value => this.isNumber(value) || ERRORS.only_numbers,
          value => this.isLengthGreatThan(value, 10) || ERRORS.minumim_length(10)
        ],
        ogrn: [
          value => !!value || ERRORS.required,
          value => this.isNumber(value) || ERRORS.only_numbers,
          value => this.isLengthGreatThan(value, 13) || ERRORS.minumim_length(13)
        ],
      }
    };
  },

  methods: {
    onSubmit() {
      Api.organizations.create(this.form).then(data => {
        this.onCreated(data);
        this.onReset();
      }).catch(error => {
        const errors = error.response.data.errors;
        console.log('errors', {...errors});
      })
    },

    onReset() {
      this.form = {};
      this.$refs.organizationForm.resetValidation();
    },

    onCreated(organization) {
      this.$emit('organization-created', organization);
    },

    isNumber(value) {
      return Number.isInteger(Number(value));
    },

    isLengthGreatThan(value, min = MINIMUM_LENGTH) {
      return value && value.length >= min ? true : false;
    },
  },
};
</script>
