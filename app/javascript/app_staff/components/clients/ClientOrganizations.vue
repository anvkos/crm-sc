<template lang="pug">
  app-modal(:title="'Organizations of client'")
    template
      add-organization-form(:client="{ id }" @organization-added="onOrganizationAdded")
      organizations-list(:items="organizations")
</template>

<script>
import Api from 'staffApi';
import AppModal from 'staffApp/components/AppModal';
import OrganizationsList from 'staffApp/components/clients/OrganizationsList';
import AddOrganizationForm from 'staffApp/components/clients/AddOrganizationForm';

export default {
  components: {
    AppModal,
    OrganizationsList,
    AddOrganizationForm,
  },

  data() {
    return {
      organizations: [],
    };
  },

  computed: {
    id() {
      return this.$route.params.id;
    },
  },

  mounted() {
    this.fetchOrganizations(this.id);
  },

  methods: {
    fetchOrganizations(id) {
      Api.clients.fetchOrganizations(id).then(data => {
        this.organizations = data;
      });
    },

    onOrganizationAdded(organization) {
      this.organizations.push(organization);
    },
  },
};
</script>
