<script setup>
import { ref, onMounted } from 'vue';
const todos = ref([]);
const API_URL = 'http://127.0.0.1:3000/todos';

const updateTodo = async () => {
  return true;
}

const createTodo = async () => {
  const res = await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      title: title.value,
      body: body.value,
    })
  })
}
</script>

<template>
  <div class="parent-container">
    <div class="dy-container">
      <h2>Create a Todo</h2>
      <input type="text" v-model="title" class="title-input" placeholder="Title...">
      <input type="text" v-model="body" class="body-input" placeholder="Description...">
      <div class="action-btns">
        <button>Create</button>
        <button v-if="isEditing" @click="updateTodo">Update</button>
        <button v-if="isEditing">Cancel</button>
      </div>
    </div>
  
    <div class="list-container">
      <h2>My Todos:</h2>
      <div class="list-item">
        <p>Hello World, I have been coding since a while.</p>
        <div class="item-btns">
          <button>Edit</button>
          <button>Delete</button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.parent-container {
  display: grid;
  grid-template-columns: repeat(2, 600px);
  gap: 5rem;
}

.dy-container {
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  gap: 1rem;
}

.title-input,
.body-input {
  width: 100%;
  padding: 12px 20px;
  box-sizing: border-box;
  border: 1px solid purple;
  border-radius: 4px;
}
.action-btns {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem;
}

.list-container {
  display: flex;
  justify-content: flex-start;
  align-items: flex-start;
  flex-direction: column;
}

.list-item {
  border: 1px solid lightcyan;
  padding: 1.2rem 2rem;
  border-radius: 1rem;
  cursor: pointer;
}
.item-btns {
  display: flex;
  justify-content: flex-start;
  align-items: center;
  gap: 1rem;
}
</style>