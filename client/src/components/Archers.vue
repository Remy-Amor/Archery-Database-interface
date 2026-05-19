<template>
    <div class="home container-fluid">
        <h1 class="text-dark">Archers</h1>
        <!-- table display -->
                 
        <div class="row">
            <div class="col-12">
                <table class="table table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Archery ID</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="archer in paginatedArchers">
                            <td scope="row">{{ archer.archeryAustraliaID }}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <p v-if="err">
                {{ err }}
            </p>
        </div>
    <paginate
            v-model="page"
            :page-count="pageCount"
            :margin-pages="2"
            :page-range="5"
            :container-class="'pagination'"
            :page-class="'page-item'"
            :page-link-class="'page-link'"
            :prev-class="'page-item'"
            :prev-link-class="'page-link'"
            :next-class="'page-item'"
            :next-link-class="'page-link'"
            :disabled-class="'disabled'"
        >
    </paginate>
    <div>
                <label for="perPage">Records per Page:</label>
                <select v-model="perPage" class="form-control w-50 d-inline ml-2" name="perPage" id="perPage">
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                </select>
            </div>
    </div>
</template>

<style>
    

</style>

<script>
    export default {
        name: "Archers",
        data() {
            return {
                archers : [],
                err: "",

                // implement later
                // archerSelection: {archerID: "", firstName: "", lastName: "", dob: "", defaultDivision: ""},
                page: 1,          // Current page
                perPage: 5,
            }
        },
        async mounted() {
            const response = await fetch('api/archers');
            this.archers = await response.json();
        },
        computed: {
            
            // filteredUnits: function() {
            //     return this.units.filter(unit => {
            //         // Type filter
            //         if (this.unitSelection.type && this.unitSelection.type !== "all") {
            //             if (unit.type.toLowerCase() !== this.unitSelection.type.toLowerCase()) {
            //                 return false;
            //             }
            //         }
                    
            //         // code filter
            //         if (this.unitSelection.code && this.unitSelection.code.trim()) {
            //             if (!unit.code.toLowerCase().includes(this.unitSelection.code.toLowerCase())) {
            //                 return false;
            //             }
            //         }
                    
            //         // cp filter
            //         if (this.unitSelection.cp && this.unitSelection.cp.trim()) {
            //             if (!unit.cp.toLowerCase().includes(this.unitSelection.cp.toLowerCase())) {
            //                 return false;
            //             }
            //         }
                    
            //         // Description filter
            //         if (this.unitSelection.description && this.unitSelection.description.trim()) {
            //             if (!unit.desc.toLowerCase().includes(this.unitSelection.description.toLowerCase())) {
            //                 return false;
            //             }
            //         }
                    
            //         return true;
            //     });
            // },
            // Calculate total number of pages
            pageCount: function() {
                return Math.ceil(this.archers.length / this.perPage);
            },
            // Get paginated results
            paginatedArchers: function() {
                const start = (this.page - 1) * this.perPage;
                const end = start + this.perPage;
                return this.archers.slice(start, end);
            },
        },
            watch: {
            // Reset to page 1 whenever filters change
            archers: {
                handler() {
                    this.page = 1;
                },
                deep: true
            }
            }
        }
        
    
</script>