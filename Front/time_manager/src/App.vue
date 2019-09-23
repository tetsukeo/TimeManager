<template>
        <div id="app">
            <div id="nav">
                <router-link to="/login">Login</router-link> |
                <router-link to="/dashboard">Dashboard</router-link>
            </div>
            <router-view/>

        </div>
</template>

<style scoped>
#app {
    width: 100%;
}
</style>
