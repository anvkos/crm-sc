<template lang="pug">
  app-modal(:title="'Organizations of client'")
    template
      add-organization-form(:client="{ id }")
      organizations-list(:items="organizations")
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import AppModal from 'staffApp/components/AppModal';
import OrganizationsList from 'staffApp/components/clients/OrganizationsList';
import AddOrganizationForm from 'staffApp/components/clients/AddOrganizationForm';

export default {
  components: {
    AppModal,
    OrganizationsList,
    AddOrganizationForm,
  },

  computed: {
    ...mapGetters({
      organizations: 'clients/clientOrganizations',
    }),

    id() {
      return this.$route.params.id;
    },
  },

  mounted() {
    this.fetchOrganizations(this.id);
  },

  methods: {
    ...mapActions({
      fetchOrganizations: 'clients/fetchOrganizations',
    }),
  },
};
</script>
