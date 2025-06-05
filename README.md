# 📚 Narrative Analysis & Predicting Plot Endings Using Sentiment  
## Wikipedia Plot Exploration + Surprise Ending Classifier  
**Author**: Trent Yu  
**Technologies**: R, tidyverse, ggplot2, tidytext, sentiment lexicons, logistic regression

---

## 🧠 Project Overview

This project uses natural language processing and sentiment analysis to analyze over 100,000 story plot summaries from Wikipedia. It focuses on two main goals:

1. **Explore the narrative structure of stories** by identifying words that frequently appear at the beginning or end.
2. **Build a classifier to predict whether a story ends happily or sadly**, based on sentiment patterns throughout the plot.

The project combines tokenization, position-based feature engineering, and logistic regression to uncover textual patterns related to narrative structure and emotional arcs.

---


## 📍 Part A – Analyzing Wikipedia Plot Structures

### 🎯 Objective

The first half of this project investigates how certain words tend to appear in specific parts of a story — early exposition vs. late resolution. The aim is to:

- Identify **narrative-positioned words** using word position deciles
- Rank words by **median position** and **frequency**
- Visualize how word distributions change over the course of a plot

---

### 📊 Visualization 1: Words by Median Position

This plot shows the top 10 words most associated with plot endings and beginnings, based on their **median word position**.

<img width="754" alt="Screenshot 2025-06-05 at 17 00 55" src="https://github.com/user-attachments/assets/ae0fd447-5919-4ecb-9a12-38ff626c4a31" />

---

### 📊 Visualization 2: Words by Frequency

This plot highlights the most frequently occurring words across all Wikipedia plot summaries.

<img width="736" alt="Screenshot 2025-06-05 at 17 01 51" src="https://github.com/user-attachments/assets/fc63651b-ebad-4b79-84f9-fe2868890304" />

---

### 📊 Visualization 3: Word Usage by Plot Deciles

Each subplot shows a single word’s frequency distribution across ten deciles (i.e., 10% slices) of the plot.  
Blue lines = words that peak near the end; Red lines = words that peak near the beginning.

<img width="1067" alt="Screenshot 2025-06-05 at 17 04 49" src="https://github.com/user-attachments/assets/252ed7c5-4d84-452f-8150-6ee1d1457018" />

🧠 **Insight**: Words like *"happily"*, *"ending"*, and *"reunited"* peak in the last decile, whereas *"eos"*, *"fictional"*, and *"california"* appear early, suggesting they function as plot openers or metadata.

---

## 🎭 Part B – Predicting Happy vs. Sad Endings

### 🎯 Objective

The second half of this project builds a **logistic regression classifier** to predict whether a story ends happily or sadly based on its sentiment trajectory.

- Deciles 1–9 (the first 90% of the story) are used as features
- Decile 10 defines the target: is the final part of the story *positive* (≥ 0.5 sentiment)?  
- Output: `is_happy_ending = 1` (happy) or `0` (sad)

The model enables **reverse storywriting** — using predicted ending sentiment to intentionally write a surprising twist.

---

### ✅ Test on a Real Plot: *Enchanted* (Disney Film)

To evaluate the classifier, I hardcoded the plot of *Enchanted* from The Walt Disney and ran it through the model.


📍 **Result**:  
The classifier predicted a probability of **~0.56**, suggesting a *moderately happy* ending.

---

### ✍️ Writing a Surprising Ending

I rewrote the ending of *Enchanted* to invert the sentiment. The new ending was **deliberately sad**, and my model returned a **decile 10 sentiment of 0.286**, confirming that it met the criteria for sadness.

> **Model-tested result**:  
> `mean_sentiment (decile 10) = 0.286 → classified as sad`

🧠 **Insight**: This approach proves that you can flip the perceived tone of a story by manipulating word-level sentiment — even without perfect grammatical structure.

---

## 💡 Reflections

- **Narrative arcs** are deeply tied to emotional patterns that show up in word choice and position.
- Simple models using decile-based sentiment patterns can approximate complex outcomes like "happy" or "sad" endings.
- **Surprise endings** can be reverse-engineered using sentiment trajectory predictions.

---

## 🧪 Future Extensions

- Train a neural classifier (e.g. LSTM) on token sequences for richer context
- Add part-of-speech tags to distinguish between expository vs. emotional words
- Use cosine similarity across plots to find “surprising” stories with similar setups but opposite endings

---


## 📝 License

This project is for portfolio and educational purposes. Plot content from Wikipedia is used under fair use for analysis.
