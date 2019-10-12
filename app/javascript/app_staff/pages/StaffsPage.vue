<template lang="pug">
  q-page
    div.row
      h4.q-mb-md.q-mt-sm Staffs232
    div.row
      div.col-8
        staffs-list(:staffs="staffs")
      div.col-4
        staff-form(@staff-created="onStaffCreated")
    router-view
</template>

<script>
import StaffsList from 'staffApp/components/staffs/StaffsList';
import StaffForm from 'staffApp/components/staffs/StaffForm';
import Api from 'staffApi';

export default {
  components: {
    StaffsList,
    StaffForm,
  },

  data() {
    return {
      staffs: [],
    };
  },

  created() {
    this.fetchStaffs();
  },

  methods: {
    fetchStaffs() {
      this.loading = true;
      Api.staffs.fetchAll().then(data => {
        this.staffs = data;
      });
    },

    onStaffCreated(staff) {
      this.staffs.push(staff);
    },
  },
};
</script>
