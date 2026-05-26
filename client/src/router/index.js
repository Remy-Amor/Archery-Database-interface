import {createRouter, createWebHistory} from "vue-router";

import Archers from "../components/Archers.vue";
import ScoreEntry from "../components/ScoreEntry.vue"


const routes = [
        {path: "/archers", name: "Archers", component: Archers},
        {path: "/score-entry", name: "ScoreEntry", component: ScoreEntry},
    ]

const router = createRouter({
    history: createWebHistory(),
    routes: routes
})

export default router;