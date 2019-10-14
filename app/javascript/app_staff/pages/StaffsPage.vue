<template lang="pug">
  q-page
    div.row
      h4.q-mb-md.q-mt-sm Staffs
    div.row
      div.col-8
        staffs-list(:staffs="staffs")
      div.col-4
        staff-form
    router-view
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import StaffsList from 'staffApp/components/staffs/StaffsList';
import StaffForm from 'staffApp/components/staffs/StaffForm';

export default {
  components: {
    StaffsList,
    StaffForm,
  },

  computed: {
    ...mapGetters({
      'staffs': 'staffs/staffs',
    }),
  },

  created() {
    this.fetchStaffs();
  },

  methods: {
    ...mapActions({
      fetchStaffs: 'staffs/fetchStaffs',
    }),
  },
};
</script>
