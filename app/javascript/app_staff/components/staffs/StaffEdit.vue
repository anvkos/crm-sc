<template lang="pug">
  AppModal(:title="'Edit'")
    .form-container
      StaffForm(v-if="staff" :staff="staff" @staff-updated="onStaffUpdated")
</template>

<script>
import Api from 'staffApi';
import AppModal from 'staffApp/components/AppModal';
import StaffForm from 'staffApp/components/staffs/StaffForm';

export default {
  components: {
    AppModal,
    StaffForm,
  },

  data() {
    return {
      staff: null,
    };
  },

  computed: {
    id() {
      return this.$route.params.id;
    },
  },

  mounted() {
    this.fetchStaff(this.id);
  },

  methods: {
    fetchStaff(id) {
      Api.staffs.fetch(id).then(data => {
        this.staff = data;
      });
    },

    onStaffUpdated() {
      this.$router.go(-1);
    }
  },
};
</script>
<style lang="styl" scoped>
  div.form-container {
    width: 400px;
  }
</style>
