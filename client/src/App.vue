<script setup>

</script>

<template>
  <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <router-link class="navbar-brand" to="/">Archery Scoring Interface</router-link>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <router-link class="nav-link" to="/archers">Archers</router-link>
          <router-link class="nav-link" to="/score-entry">Enter a Score</router-link>

        </li>
        
      </ul>
      <span class="navbar-text">
        An archery database interface!
      </span>
    </div>
  </div>
</nav>
  <router-view></router-view>
</template>
