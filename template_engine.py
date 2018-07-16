from jinja2 import Environment, FileSystemLoader


def main():

    env = Environment(loader=FileSystemLoader('.'))
    template = env.get_template('Dockerfile.j2')

    users = get_user_list()

    arg_dic = dict(
        password='nccy',
        user_list=users
    )

    output = template.render(arg_dic)

    with open('Dockerfile', "w") as f:
        f.write(output)


def get_user_list():
    user_list = [
        dict(
            name='hiroki',
            uid=100,
            sudo='true',
            pub='dddddddddddddddddddddddd'
        ),
        dict(
            name='yoshiki',
            uid=101,
            sudo='true',
            pub='jjjjjjjjjjjjjjjjjjjjjjjjjj'
        ),
        dict(
            name='takano',
            uid=102,
            sudo='false',
            pub='eeeeeeeeeeeeeeeeeeee'
        ),
    ]

    return user_list


if __name__ == '__main__':
    main()
