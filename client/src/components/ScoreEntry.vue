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
            <div class="col-12 text-center">
                <h3 class="text-dark">Choose Archer</h3>
                <select name="archers" id="archers" v-model="selectedArcher">
                    <option v-for="archer in archers" :value="archer">{{ archer.firstName + " " + archer.lastName }}</option>
                </select>
            </div>

            <select v-if="selectedArcher"
              v-model="selectedArcher.defaultDivision" 
              @change="updateDivision(selectedArcher)"
              class="form-select form-select-sm"
            >
              <option value="B">Barebow (B)</option>
              <option value="C">Compound (C)</option>
              <option value="R">Recurve (R)</option>
              <option value="L">Longbow (L)</option>
            </select>
        </div>
    </div>
</template>

<style>
    

</style>

<script>
    import {get, put} from '../utils/apiHelper.js';
    export default {
        name: "ScoreEntry",
        data() {
            return {
                rounds : [],
                selectedRound : null,
                archers: [],
                selectedArcher : null
            }
        },
        async mounted() {
            this.rounds = await get('/rounds');
            this.archers = await get('/archers');
        },
        methods : {
            updateDivision(archer) {
                put(`/archers/${archer.archeryAustraliaID}/set-division`);
            }
        }
        
    }
        
    
</script>