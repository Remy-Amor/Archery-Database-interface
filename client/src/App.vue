<script setup>
  async function getArchers() {
  try {
    const response = await fetch('/api/archers');
    const data = await response.json();
    console.log('Archers:', data);  // ← Open browser console to see this
  } catch (error) {
    console.error('Error:', error);
  }
}
</script>

<template>
  <h1>Test Page</h1>
  <button @click="getArchers">Get archers</button>
</template>
