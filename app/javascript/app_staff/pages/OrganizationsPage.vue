<template lang="pug">
  q-page
    .row
      .col-8
        organizations-list(:items="organizations" @organizations-deleted="onOrganizationDeleted")
      .col-4
        organization-form(@organization-created="onOrganizationCreated")
    router-view
</template>

<script>
import Api from 'staffApi';
import OrganizationsList from '../components/organizations/OrganizationsList';
import OrganizationForm from '../components/organizations/OrganizationForm';

export default {
  components: {
    OrganizationsList,
    OrganizationForm,
  },

  data() {
    return {
      organizations: [],
    };
  },

  created() {
    this.fetchOrganizations();
  },

  methods: {
    fetchOrganizations() {
      this.loading = true;
      Api.organizations.fetchAll().then(data => {
        this.organizations = data;
      });
    },

    onOrganizationCreated(organization) {
      this.organizations.push(organization);
    },

    onOrganizationDeleted(organizationIds) {
      organizationIds.forEach(id => {
        Api.organizations.destroy(id).then(data => {
          this.delete(id);
        });
      });
    },

    delete(id) {
      const index = this.organizations.findIndex(item => item.id === id);
      this.organizations.splice(index, 1);
    },
  }
}
</script>
