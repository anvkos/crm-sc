<template lang="pug">
  div#app
    NavBar(:user="user" @user-signout="signOut")
</template>

<script>
import NavBar from './app_staff/components/AppNavBar';
import { fetchUser, signOut } from './app_staff/api/auth';

export default {
  components: {
    NavBar
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
        .then(data => {
          this.user = data.user;
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
