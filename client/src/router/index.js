import {createRouter, createWebHistory} from "vue-router";

import Archers from "../components/Archers.vue";


const routes = [
        {path: "/archers", name: "Archers", component: Archers},
        
    ]

const router = createRouter({
    history: createWebHistory(),
    routes: routes
})

export default router;