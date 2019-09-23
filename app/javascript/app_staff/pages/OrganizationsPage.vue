<template lang="pug">
  QPage
    div(class="row")
      OrganizationsList(:items="organizations" class="col-8")
      OrganizationForm(class="col-4" @organization-created="onOrganizationCreated")
</template>

<script>
import Api from '../api';
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
  }
}
</script>
