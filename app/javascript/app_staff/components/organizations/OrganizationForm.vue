<template lang="pug">
  div(class="q-pa-md rounded-borders")
    h6(class="q-my-md") Add Organization
    QForm(
      class="q-gutter-y-md column"
      ref="organizationForm"
      @reset="onReset"
      @submit="onSubmit"
    )
      QInput(
        v-model="form.name"
        outlined
        label="Name *"
        hint="Enter organization name"
        placeholder="Company Ltd."
        :rules="rules.name"
      )
      QSelect(
        v-model="form.kind"
        outlined
        :options="kinds"
        label="Type"
        hint="Select organization type"
        required
      )
      QInput(
        v-model="form.inn"
        outlined
        label="INN *"
        hint="Enter organization INN"
        :rules="rules.inn"
      )
      QInput(
        v-model="form.ogrn"
        outlined
        label="OGRN *"
        hint="Enter organization OGRN"
        :rules="rules.ogrn"
      )
      div(class="row q-pa-md q-gutter-md justify-end")
        QBtn(label="Reset" type="reset" color="white" text-color="black")
        QBtn(label="Save" type="submit" color="secondary")

</template>

<script>
import Api from '../../api';
import { QForm, QInput, QSelect } from 'quasar';

const ERRORS = {
  required: 'Field is required',
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
        name: [value => !!value || ERRORS.required],
        inn: [value => !!value || ERRORS.required],
        ogrn: [value => !!value || ERRORS.required],
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
  },
};
</script>
