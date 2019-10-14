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
      :options="organizationsFiltered"
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
import { mapGetters, mapActions } from 'vuex';
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
      form: {},
      rules: {
        type: [value => !!value || VALIDATION_ERRORS.select('organization')],
      },
    };
  },

  computed: {
    ...mapGetters({
      organizations: 'organizations/organizations',
      clientOrganizations: 'clients/clientOrganizations',
    }),

    organizationsFiltered() {
      const excludeIds = this.clientOrganizations.map(item => item.id);
      return this.organizations.filter(organization => excludeIds.indexOf(organization.id) === -1);
    },
  },

  created() {
    this.fetchOrganizations();
  },

  methods: {
    ...mapActions({
      addOrganization: 'clients/addOrganization',
      fetchOrganizations: 'organizations/fetchAll',
    }),

    onSubmit() {
      this.addOrganization({id: this.client.id, organization: this.form }).then(() => {
        this.onReset();
      });
    },

    onReset() {
      this.form = {};
      this.$refs.addOrganizationForm.resetValidation();
    },
  },
};
</script>
