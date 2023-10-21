from robot.api.deco import keyword
from pymongo import MongoClient
import certifi
import bcrypt

mongo_uri = 'mongodb+srv://qa:xperience@cluster0.rkdssq0.mongodb.net/?retryWrites=true&w=majority'

client = MongoClient(mongo_uri, tlsCAFile=certifi.where())

db = client['markdb']

@keyword('Clean user from database')
def clean_user(user_email):
    users = db['users']
    tasks = db['tasks']

    #buscando por um usuário cujo email seja user_email e guardo na variável u
    u = users.find_one({'email':user_email})

    if (u):
        #deleta todas as tarefas cadastradas para esse usuário e depois deleta o usuário
        tasks.delete_many({'user': u['_id']})
        users.delete_many({'email': user_email})

@keyword('Remove user from database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

#metodo que irá inserir um usuario no banco de dados com criptografia
@keyword('Insert user from database')
def insert_user(user):

    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))

    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass
    }

    users = db['users']
    users.insert_one(doc)
    print(user)