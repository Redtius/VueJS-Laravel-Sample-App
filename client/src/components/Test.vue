<template>
  <div>
    <input type="text" v-model="newWord" @keyup.enter="addWord">
    <button @click="addWord">Add Word</button>
    
    <div>
      <h2>Words:</h2>
      <ul>
        <li v-for="word in words" :key="word.id">{{ word.text }}</li>
      </ul>
      <button @click="fetchWords">Refresh</button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      newWord: '',
      words: []
    };
  },
  mounted() {
    this.fetchWords();
  },
  methods: {
    addWord() {
      // Send POST request to backend to add new word
      fetch('http://api.redamountassir.site/api/words', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ text: this.newWord })
      })
      .then(response => response.json())
      .then(data => {
        // Add newly added word to words array
        this.words.push(data);
        this.newWord = ''; // Clear input field
      })
      .catch(error => {
        console.error('Error adding word:', error);
      });
    },
    fetchWords() {
      // Send GET request to fetch words from backend
      fetch('http://api.redamountassir.site:8000/api/words')
      .then(response => response.json())
      .then(data => {
        this.words = data;
      })
      .catch(error => {
        console.error('Error fetching words:', error);
      });
    }
  }
};
</script>
