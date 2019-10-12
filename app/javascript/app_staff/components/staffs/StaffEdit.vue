<template lang="pug">
  app-modal(:title="'Edit'")
    .form-container
      staff-form(v-if="staff" :staff="staff" @staff-updated="onStaffUpdated")
</template>

<script>
import { mapGetters, mapActions } from 'vuex';
import AppModal from 'staffApp/components/AppModal';
import StaffForm from 'staffApp/components/staffs/StaffForm';

export default {
  components: {
    AppModal,
    StaffForm,
  },

  computed: {
    ...mapGetters({
      staff: 'staffs/staff',
    }),

    id() {
      return this.$route.params.id;
    },
  },

  mounted() {
    this.fetchStaff(this.id);
  },

  methods: {
    ...mapActions({
      fetchStaff: 'staffs/fetchStaff',
    }),

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
