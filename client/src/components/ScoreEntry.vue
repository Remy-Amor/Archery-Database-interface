<template>
    <div class="home container-fluid">
        <h1 class="text-dark">Enter a Score</h1>         
        <div class="row">
            <div class="col-12 text-center">
                <h3 class="text-dark">Choose Round</h3>
                <select name="rounds" id="rounds" v-model="selectedRound">
                    <option v-for="round in rounds" :value="round">{{ round.roundName }}</option>
                </select>
            </div>
        </div>
    </div>
</template>

<style>
    

</style>

<script>
    export default {
        name: "ScoreEntry",
        data() {
            return {
                rounds : [],
                selectedRound : null
            }
        },
        async mounted() {
            const response = await fetch('api/rounds');
            this.rounds = await response.json();
        },
        computed: {
        methods: {
              
        }
        }
    }
        
    
</script>