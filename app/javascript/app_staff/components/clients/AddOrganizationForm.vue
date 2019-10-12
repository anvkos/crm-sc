<template lang="pug">
  q-form(
    class="q-gutter-y-md column"
    ref="addOrganizationForm"
    @reset="onReset"
    @submit="onSubmit"
  )
    q-select(
      v-model="form.organization_id"
      dense
      outlined
      :options="organizations"
      option-value="id"
      option-label="name"
      emit-value
      map-options
      label="Organization"
      hint="Select organization"
      lazy-rules
      :rules="rules.type"
    )
      template(v-slot:after)
        q-btn(type="submit" label="Add" color="primary")
</template>

<script>
import { QForm, QSelect } from 'quasar';
import Api from 'staffApi';
import { VALIDATION_ERRORS } from 'staffApp/mixins/validator';

export default {
  components: {
    QForm,
    QSelect,
  },

  props: {
    client: {
      type: Object,
      required: true,
    },
  },

  data() {
    return {
      organizations: [],
      form: {},
      rules: {
        type: [value => !!value || VALIDATION_ERRORS.select('organization')],
      },
    };
  },

  created() {
    this.fetchOrganization();
  },

  methods: {
    onSubmit() {
      Api.clients.addOrganization(this.client.id, this.form).then(data => {
        this.onAdded(data);
        this.onReset();
      });
    },

    onReset() {
      this.form = {};
      this.$refs.addOrganizationForm.resetValidation();
    },

    fetchOrganization() {
      Api.organizations.fetchAll().then(data => {
        data.forEach(item => this.organizations.push({
            id: item.id,
            name: item.name,
          })
        );
      });
    },

    onAdded(organization) {
      this.$emit('organization-added', organization);
    },
  },
};
</script>
