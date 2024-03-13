from sentence_transformers import SentenceTransformer
import spacy
class TextProcessor:
    def __init__(self, model_name="msmarco-distilbert-dot-v5", nlp_model="en_core_web_sm"):
        self.model = SentenceTransformer(model_name)
        self.nlp = spacy.load(nlp_model)
        
    def preprocess_text(self, query):
        doc = self.nlp(query)
        tokens = [token.lemma_.lower() for token in doc if not token.is_stop and not token.is_punct]
        preprocessed_text = ' '.join(tokens)
        return preprocessed_text

    def encode_text(self, preprocessed_query):
        return self.model.encode([preprocessed_query])
