<template lang="pug">
  QPage
    OrganizationsList(:items="organizations")
</template>

<script>
import Api from '../api';
import OrganizationsList from '../components/organizations/OrganizationsList';

export default {
  components: {
    OrganizationsList,
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
  }
}
</script>
