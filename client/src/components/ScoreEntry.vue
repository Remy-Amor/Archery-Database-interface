<template>
  <div class="home container-fluid py-4">
    <h1 class="text-dark mb-4">Enter a Score</h1>

    <!-- Loading overlay -->
    <div v-if="isLoading" class="loading-overlay">
      <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Loading...</span>
      </div>
    </div>

    <div class="row justify-content-center">
      <!-- Round Selection -->
      <div class="col-12 col-md-6 mb-4">
        <div class="card shadow-sm">
          <div class="card-body">
            <h3 class="card-title text-dark mb-3">
              Choose Round
            </h3>
            <select
              v-model="selectedRound"
              class="form-select form-select-lg"
              @change="onRoundChanged"
            >
              <option :value="null" disabled>-- Select a Round --</option>
              <option v-for="round in rounds" :key="round.roundID" :value="round">
                {{ round.roundName }}
              </option>
            </select>
          </div>
        </div>
      </div>

      <!-- Archer Selection -->
      <div class="col-12 col-md-6 mb-4">
        <div class="card shadow-sm">
          <div class="card-body">
            <h3 class="card-title text-dark mb-3">
              Choose Archer
            </h3>
            <select
              v-model="selectedArcher"
              class="form-select form-select-lg"
              @change="onArcherChanged"
            >
              <option :value="null" disabled>-- Select an Archer --</option>
              <option v-for="archer in archers" :key="archer.id" :value="archer">
                {{ archer.firstName + " " + archer.lastName }}
              </option>
            </select>
          </div>
        </div>
      </div>

      <!-- Division Editor (only if archer selected) -->
      <div v-if="selectedArcher" class="col-12 col-md-8">
        <div class="card shadow-sm mb-4">
          <div class="card-body">
            <h3 class="card-title text-dark mb-3">
             Division Settings
            </h3>
            <div class="row align-items-center">
              <div class="col-md-6 mb-3 mb-md-0">
                <label class="form-label fw-bold">
                  Default Division for {{ selectedArcher.firstName }}
                </label>
                <select
                  v-model="divisionBeingEdited"
                  class="form-select form-select-lg"
                  :disabled="isSaving"
                >
                  <option value="B">Barebow (B)</option>
                  <option value="C">Compound (C)</option>
                  <option value="R">Recurve (R)</option>
                  <option value="L">Longbow (L)</option>
                </select>
              </div>
              <div class="col-md-6 d-flex gap-2">
                <button
                  @click="saveDivision"
                  class="btn btn-success btn-lg flex-grow-1"
                  :disabled="isSaving || !hasDivisionChanged"
                >
                  <span v-if="isSaving" class="spinner-border spinner-border-sm me-2"></span>
                  {{ isSaving ? 'Saving...' : 'Save Division' }}
                </button>
                <button
                  @click="cancelEdit"
                  class="btn btn-outline-secondary btn-lg"
                  :disabled="isSaving"
                >
                  Cancel
                </button>
              </div>
            </div>
            <div v-if="saveMessage" class="mt-3">
              <div :class="saveSuccess ? 'alert alert-success' : 'alert alert-danger'">
                {{ saveMessage }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- SCORING INTERFACE (shown after both round and archer selected) -->
      <div v-if="selectedRound && selectedArcher && !showScoring" class="col-12 text-center mt-4">
        <button @click="startScoring" class="btn btn-primary btn-lg">
          Start Scoring
        </button>
      </div>

      <div v-if="showScoring && ranges.length > 0" class="col-12 col-lg-10">
        <div class="card shadow-sm">
          <div class="card-body">
            <h3 class="card-title text-dark mb-3">
              Scoring for {{ selectedArcher.firstName }} – {{ selectedRound.roundName }}
            </h3>

            <!-- Current range & end info -->
            <div class="alert alert-info">
              <strong>Range {{ currentRangeIdx + 1 }} of {{ ranges.length }}</strong>
              – Distance: {{ ranges[currentRangeIdx].distance }} m<br />
              <strong>End {{ currentEndIdx + 1 }} of {{ ranges[currentRangeIdx].endCount }}</strong>
            </div>

            <!-- Arrow inputs for the current end -->
            <div class="row g-3 mb-4">
              <div
                v-for="(arrow, idx) in currentEndScores"
                :key="idx"
                class="col-6 col-sm-4 col-md-2"
              >
                <label class="form-label fw-bold">Arrow {{ idx + 1 }}</label>
                <select
                  v-model="currentEndScores[idx]"
                  class="form-select form-select-lg"
                >
                  <option v-for="opt in arrowOptions" :key="opt.value" :value="opt.value">
                    {{ opt.label }}
                  </option>
                </select>
              </div>
            </div>

            <!-- Navigation -->
            <div class="d-flex flex-column align-items-center mt-4">
            <paginate
                v-model="currentPage"
                :page-count="totalEnds"
                :page-range="3"
                :margin-pages="1"
                :click-handler="() => {}"
                :prev-text="'← Prev'"
                :next-text="'Next →'"
                :container-class="'pagination justify-content-center'"
                :page-class="'page-item'"
                :page-link-class="'page-link'"
                :prev-class="'page-item'"
                :prev-link-class="'page-link'"
                :next-class="'page-item'"
                :next-link-class="'page-link'"
                :active-class="'active'"
                :disabled-class="'disabled'"
            ></paginate>

            <!-- Submit button only on last end -->
            <button
                v-if="currentPage === totalEnds"
                @click="submitScores"
                class="btn btn-success btn-lg mt-3"
                :disabled="isSubmitting"
            >
                <span v-if="isSubmitting" class="spinner-border spinner-border-sm me-2"></span>
                {{ isSubmitting ? 'Submitting...' : 'Submit Scores' }}
            </button>
            </div>

            <!-- Submission message -->
            <div v-if="submitMessage" class="mt-3">
              <div :class="submitSuccess ? 'alert alert-success' : 'alert alert-danger'">
                {{ submitMessage }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Paginate from 'vuejs-paginate-next'; 
import { get, put, post } from '../utils/apiHelper.js';

export default {
  name: 'ScoreEntry',
  components : {
    Paginate,
  },
  data() {
    return {
      rounds: [],
      selectedRound: null,
      archers: [],
      selectedArcher: null,
      divisionBeingEdited: '',
      originalDivision: '',
      isLoading: false,
      isSaving: false,
      saveMessage: '',
      saveSuccess: false,
      showScoring: false,
      ranges: [],            // fetched from API after selecting round
      endsData: [],          // nested structure: array of ranges, each with an array of end arrays (6 scores)
      currentPage : 1, // pagination
      isSubmitting: false,
      submitMessage: '',
      submitSuccess: false,
      arrowOptions: [
        { label: 'M (miss)', value: '0' },
        { label: '1', value: '1' },
        { label: '2', value: '2' },
        { label: '3', value: '3' },
        { label: '4', value: '4' },
        { label: '5', value: '5' },
        { label: '6', value: '6' },
        { label: '7', value: '7' },
        { label: '8', value: '8' },
        { label: '9', value: '9' },
        { label: '10', value: '10' },
        { label: 'X', value: 'X' }
      ]
    };
  },
  computed: {
    hasDivisionChanged() {
      return this.divisionBeingEdited !== this.originalDivision;
    },
    currentGlobalEndIdx() {
        return this.currentPage - 1;
    },
    // Flatten ends for easy pagination
    flattenedEnds() {
      const flat = [];
      for (const range of this.endsData) {
        for (let i = 0; i < range.ends.length; i++) {
          flat.push({
            rangeIdx: range.rangeIdx,
            endIdx: i,
            scores: range.ends[i]
          });
        }
      }
      return flat;
    },
    totalEnds() {
      return this.flattenedEnds.length;
    },
    currentEndScores() {
      const entry = this.flattenedEnds[this.currentGlobalEndIdx];
      return entry ? entry.scores : [];
    },
    currentRangeIdx() {
      const entry = this.flattenedEnds[this.currentGlobalEndIdx];
      return entry ? entry.rangeIdx : 0;
    },
    currentEndIdx() {
      const entry = this.flattenedEnds[this.currentGlobalEndIdx];
      return entry ? entry.endIdx : 0;
    },
    isFirstEnd() {
      return this.currentGlobalEndIdx === 0;
    },
    isLastEnd() {
      return this.currentGlobalEndIdx >= this.totalEnds - 1;
    }
  },
  watch: {
    selectedArcher(newVal) {
      this.saveMessage = '';
      this.saveSuccess = false;
      if (newVal) {
        this.divisionBeingEdited = newVal.defaultDivision || '';
        this.originalDivision = newVal.defaultDivision || '';
      }
      this.showScoring = false;
      this.ranges = [];
      this.endsData = [];
    },
    selectedRound() {
      this.showScoring = false;
      this.ranges = [];
      this.endsData = [];
    }, // pagination:
    showScoring(newVal) {
      if (newVal) this.currentPage = 1;
    },
    selectedRound() {
      this.currentPage = 1;
      this.showScoring = false;
    },
    selectedArcher() {
      this.currentPage = 1;
      this.showScoring = false;
    }
  },
  async mounted() {
    this.isLoading = true;
    try {
      this.rounds = await get('/rounds');
      this.archers = await get('/archers');
    } catch (error) {
      console.error('Failed to load data:', error);
    } finally {
      this.isLoading = false;
    }
  },
  methods: {
    // Division save (unchanged)
    async saveDivision() {
      if (!this.selectedArcher || !this.hasDivisionChanged) return;
      this.isSaving = true;
      this.saveMessage = '';
      try {
        await put(
          `/archers/${this.selectedArcher.archeryAustraliaID}/set-division`,
          { division: this.divisionBeingEdited }
        );
        this.selectedArcher.defaultDivision = this.divisionBeingEdited;
        this.originalDivision = this.divisionBeingEdited;
        this.saveSuccess = true;
        this.saveMessage = 'Division updated';
        setTimeout(() => { this.saveMessage = ''; }, 3000);
      } catch (error) {
        this.saveSuccess = false;
        this.saveMessage = `Error: ${error.message}`;
      } finally {
        this.isSaving = false;
      }
    },
    cancelEdit() {
      this.divisionBeingEdited = this.originalDivision;
      this.saveMessage = '';
    },
    // Fetch ranges and prepare scoring data
    async startScoring() {
      if (!this.selectedRound || !this.selectedArcher) return;
      try {
        this.isLoading = true;
        const ranges = await get(`/rounds/${this.selectedRound.roundID}/ranges`);
        this.ranges = ranges; // array of {rangeSequence, rangeID, distance, endCount}
        // Build endsData structure
        this.endsData = ranges.map((r, idx) => ({
          rangeIdx: idx,
          rangeID: r.rangeID,
          distance: r.distance,
          endCount: r.endCount,
          rangeSequence: r.rangeSequence,
          ends: Array.from({ length: r.endCount }, () =>
            new Array(6).fill('M')   // default to miss
          )
        }));
        this.currentGlobalEndIdx = 0;
        this.showScoring = true;
        this.submitMessage = '';
      } catch (error) {
        console.error('Failed to load ranges:', error);
        alert('Failed to load round ranges.');
      } finally {
        this.isLoading = false;
      }
    },
    async submitScores() {
      if (!this.selectedArcher || !this.selectedRound) return;

      // Prepare payload
      const payload = {
        archerID: this.selectedArcher.archeryAustraliaID,
        roundID: this.selectedRound.roundID,
        ends: this.endsData.map(range => ({
          rangeID: range.rangeID,
          rangeSequence: range.rangeSequence,
          scores: range.ends   // array of 6-element arrays
        }))
      };

      this.isSubmitting = true;
      this.submitMessage = '';
      try {
        const result = await post('/individual-recorded-rounds', payload);
        this.submitSuccess = true;
        this.submitMessage = `Scores submitted! Total: ${result.totalScore}`;
        // Optionally reset
        setTimeout(() => {
          this.showScoring = false;
          this.submitMessage = '';
        }, 3000);
      } catch (error) {
        this.submitSuccess = false;
        this.submitMessage = `Error: ${error.message}`;
      } finally {
        this.isSubmitting = false;
      }
    }
  }
};
</script>

<style scoped>
/* Keep your existing styles + add any new ones */
.home {
  max-width: 1200px;
  margin: 0 auto;
}
/* ... your existing card, button, form-select styles ... */
</style>