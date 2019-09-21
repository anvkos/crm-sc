<template lang="pug">
  div#app.q-pa-md
    QLayout(view="hhh Lpr fff" class="shadow-2 rounded-borders")
      AppHeader(
        :user="user"
        @click-toggle-visibility-sidebar="toggleVisibilitySidebar"
        @user-signout="signOut"
      )
      AppSidebar(:visible="sidebarVisible")

      QPageContainer
        QInnerLoading(:showing="loading")
          QSpinner(
            color="primary"
            size="3em"
            :thickness="5"
          )
        IndexPage(v-show="!loading")

</template>

<script>
import { QSpinner, QInnerLoading } from 'quasar';
import AppHeader from './app_staff/components/AppHeader';
import AppSidebar from './app_staff/components/AppSidebar';
import { fetchUser, signOut } from './app_staff/api/auth';
import IndexPage from './app_staff/pages/IndexPage';


export default {
  components: {
    QSpinner,
    QInnerLoading,
    AppHeader,
    AppSidebar,
    IndexPage,
  },

  data: function () {
    return {
      user: null,
      loading: true,
      sidebarVisible: false,
    };
  },

  created() {
    this.loadUser();
  },

  methods: {
    loadUser() {
      fetchUser()
        .then(user => {
          this.user = user;
          this.loading = false;
        })
        .catch(error => {
          console.log(error);
        })
        .finally(() => this.loading = false);
    },

    signOut() {
      signOut().then(data => {
        window.location.href = "/";
      });
    },

    toggleVisibilitySidebar() {
      this.sidebarVisible = !this.sidebarVisible;
    },
  },
};
</script>

<style lang="scss" scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
