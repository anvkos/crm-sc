<template lang="pug">
  div#app
    NavBar(:user="user" @user-signout="signOut")
    Dashboard
</template>

<script>
import NavBar from './app_staff/components/AppNavBar';
import { fetchUser, signOut } from './app_staff/api/auth';
import Dashboard from './app_staff/components/AppDashboard';

export default {
  components: {
    NavBar,
    Dashboard,
  },

  data: function () {
    return {
      user: null,
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
        })
        .catch(error => {
          console.log(error);
        });
    },

    signOut() {
      signOut().then(data => {
        window.location.href = "/";
      });
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
