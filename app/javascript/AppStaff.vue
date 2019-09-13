<template lang="pug">
  div#app
    NavBar(:user="user")
    p {{ message }}
</template>

<script>
import NavBar from './app_staff/components/AppNavBar';

export default {
  components: {
    NavBar
  },

  data: function () {
    return {
      message: "Hello Staff!",
      user: {
        name: 'UserName',
      },
    };
  },
}
</script>

<style lang="scss" scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
