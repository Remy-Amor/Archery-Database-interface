<script setup>
//   archersList = {};

//   async function getArchers() {
//   try {
//     const response = await fetch('/api/archers');
//     const data = await response.json();
//     archersList = data;
//   } catch (error) {
//     console.error('Error:', error);
//   }
// }
</script>

<template>
  <nav class="navbar navbar-dark">
    <router-link class="nav-link" to="/archers">Archers</router-link>
  </nav>
  <router-view></router-view>
</template>
