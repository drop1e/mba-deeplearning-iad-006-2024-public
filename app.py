from flask import Flask, request, jsonify
import pickle

app = Flask(__name__)

# Carregar o modelo treinado
with open('./app/model/model_xgboost.pkl', 'rb') as f:
    model = pickle.load(f)

@app.route('/main', methods=['POST'])
def main():
    data = request.json
    prediction = model.predict([data['features']])
    return jsonify({'prediction': prediction.tolist()})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7000, debug=True)



# Endpoint de Healthcheck
@app.get("/healthcheck")
async def healthcheck():
    # retorna um objeto com um campo status com valor "ok" se a aplicação estiver funcionando corretamente
    return {"status": "ok"}
