<template>
    <div class="home container-fluid py-4">
        <h1 class="text-dark mb-4">Enter a Score</h1>
        
        <!-- Loading Overlay -->
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
                            <i class="bi bi-bullseye me-2"></i>Choose Round
                        </h3>
                        <select 
                            name="rounds" 
                            id="rounds" 
                            v-model="selectedRound"
                            class="form-select form-select-lg"
                        >
                            <option :value="null" disabled>-- Select a Round --</option>
                            <option v-for="round in rounds" :key="round.id" :value="round">
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
                            <i class="bi bi-person me-2"></i>Choose Archer
                        </h3>
                        <select 
                            name="archers" 
                            id="archers" 
                            v-model="selectedArcher"
                            class="form-select form-select-lg"
                        >
                            <option :value="null" disabled>-- Select an Archer --</option>
                            <option v-for="archer in archers" :key="archer.id" :value="archer">
                                {{ archer.firstName + " " + archer.lastName }}
                            </option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Division Editor -->
            <div v-if="selectedArcher" class="col-12 col-md-8">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h3 class="card-title text-dark mb-3">
                            <i class="bi bi-gear me-2"></i>Division Settings
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
                        
                        <!-- Success/Error Messages -->
                        <div v-if="saveMessage" class="mt-3">
                            <div :class="saveSuccess ? 'alert alert-success' : 'alert alert-danger'">
                                {{ saveMessage }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.home {
    max-width: 1200px;
    margin: 0 auto;
}

.card {
    border: none;
    border-radius: 10px;
    transition: transform 0.2s;
}

.card:hover {
    transform: translateY(-2px);
}

.card-title {
    font-size: 1.25rem;
    font-weight: 600;
}

.form-select {
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    padding: 12px 16px;
    transition: border-color 0.2s;
}

.form-select:focus {
    border-color: #0d6efd;
    box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
}

.form-select:disabled {
    background-color: #f8f9fa;
    cursor: not-allowed;
}

.loading-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(255, 255, 255, 0.8);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
}

.btn {
    border-radius: 8px;
    padding: 12px 24px;
    font-weight: 600;
    transition: all 0.2s;
}

.btn-success {
    background-color: #28a745;
    border: none;
}

.btn-success:hover:not(:disabled) {
    background-color: #218838;
    transform: translateY(-1px);
}

.btn-success:disabled {
    background-color: #6c757d;
    cursor: not-allowed;
}

.spinner-border {
    width: 1.2rem;
    height: 1.2rem;
}
</style>

<script>
import { get, put } from '../utils/apiHelper.js';

export default {
    name: "ScoreEntry",
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
            saveSuccess: false
        }
    },
    computed: {
        hasDivisionChanged() {
            return this.divisionBeingEdited !== this.originalDivision;
        }
    },
    watch: {
        selectedArcher(newArcher, oldArcher) {
            // Reset save state when switching archers
            this.saveMessage = '';
            this.saveSuccess = false;
            
            if (newArcher) {
                this.divisionBeingEdited = newArcher.defaultDivision || '';
                this.originalDivision = newArcher.defaultDivision || '';
            }
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
        async saveDivision() {
            if (!this.selectedArcher || !this.hasDivisionChanged) return;
            
            this.isSaving = true;
            this.saveMessage = '';
            
            try {
                const updatedArcher = await put(
                    `/archers/${this.selectedArcher.archeryAustraliaID}/set-division`,
                    { division: this.divisionBeingEdited }
                );
                
                // Update the archer in the list
               this.archers = await get('/archers');
                
                // Show success message
                this.saveSuccess = true;
                this.saveMessage = `Division updated to ${this.getDivisionFullName(this.divisionBeingEdited)}`;
                
                // Auto-hide success message after 3 seconds
                setTimeout(() => {
                    this.saveMessage = '';
                }, 3000);
                
            } catch (error) {
                this.saveSuccess = false;
                this.saveMessage = `Error: ${error.message || 'Failed to update division'}`;
            } finally {
                this.isSaving = false;
            }
        },
        cancelEdit() {
            this.divisionBeingEdited = this.originalDivision;
            this.saveMessage = '';
            this.saveSuccess = false;
        },
        getDivisionFullName(code) {
            const divisions = {
                'B': 'Barebow',
                'C': 'Compound',
                'R': 'Recurve',
                'L': 'Longbow'
            };
            return divisions[code] || code;
        }
    }
}
</script>