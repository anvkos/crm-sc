<template lang="pug">
  div.q-pa-md.rounded-borders
    h6.q-mb-md.q-mt-sm
      | {{ editing ? 'Organization' : 'Add Organization'}}
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
import { mapActions } from 'vuex';
import { QForm, QInput, QSelect } from 'quasar';
import { validator, validatorErrors, VALIDATION_ERRORS } from 'staffApp/mixins/validator';

const ORGANIZATION_KINDS = ['ИП', 'ЮЛ'];

export default {
  components: {
    QForm,
    QInput,
    QSelect,
  },

  mixins: [validator, validatorErrors],

  props: {
    organization: {
      type: Object,
    },
  },

  computed: {
    editing() {
      return !!this.organization;
    },
  },

  data() {
    return {
      form: {},
      kinds: ORGANIZATION_KINDS,
      rules: {
        name: [
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isLengthGreatThan(value, 5) || VALIDATION_ERRORS.minumim_length(5)
        ],
        kind: [value => !!value || VALIDATION_ERRORS.select('organization')],
        inn: [
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isNumber(value) || VALIDATION_ERRORS.only_numbers,
          value => this.isLengthGreatThan(value, 10) || VALIDATION_ERRORS.minumim_length(10),
        ],
        ogrn: [
          value => !!value || VALIDATION_ERRORS.required,
          value => this.isNumber(value) || VALIDATION_ERRORS.only_numbers,
          value => this.isLengthGreatThan(value, 13) || VALIDATION_ERRORS.minumim_length(13),
        ],
      }
    };
  },

  created() {
    this.setDataForm(this.organization);
  },

  methods: {
    ...mapActions({
      createOrganization: 'organizations/create',
      updateOrganization: 'organizations/update',
    }),

    setDataForm(organization) {
      if (!organization) { return; }
      ['name', 'kind', 'inn', 'ogrn'].forEach(key => {
        this.form[key] = organization[key];
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
      this.$refs.organizationForm.resetValidation();
    },

    onUpdate() {
      this.$emit('organization-updated');
    },

    create() {
      this.createOrganization(this.form).then(data => {
        this.onReset();
      }).catch(error => {
        const errors = error.response.data.errors;
        this.fillErrors(errors);
      });
    },

    update() {
      this.updateOrganization({ id: this.organization.id, params: this.form }).then(() => {
        this.onUpdate();
        this.onReset();
      }).catch(error => {
        const errors = error.response.data.errors;
        this.fillErrors(errors);
      });
    },
  },
};
</script>
