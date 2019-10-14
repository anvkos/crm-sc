<template lang="pug">
  q-page
    .row
      .col-8
        organizations-list(:items="organizations")
      .col-4
        organization-form
    router-view
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import OrganizationsList from '../components/organizations/OrganizationsList';
import OrganizationForm from '../components/organizations/OrganizationForm';

export default {
  components: {
    OrganizationsList,
    OrganizationForm,
  },

  computed: {
    ...mapGetters({
      organizations: 'organizations/organizations',
    }),
  },

  created() {
    this.fetchOrganizations();
  },

  methods: {
    ...mapActions({
      fetchOrganizations: 'organizations/fetchAll',
    }),
  }
}
</script>
