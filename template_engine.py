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
            uid=1000,
            sudo='true',
            pub='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnP2lzJsO2QSWic58lB6ha6ShqoKXaSUS0lG1uQ4HCtY7VR5DLCF7IEDJb0t8nnA6NhHhlowKunCwoASYWvqvjmrjkMii6+nN3U9wfXQhCdAJV2NB9fHUxRFYKOzsTbO4K8YhlWr6EWFbkWI4vzqpyez625veTxBujVgY3paXYzUqRBjmdGMaH/15skHRxYKrbD/VjumIkF2RG+suJANogvsUko3am98+8iEiD0vizOoraKZgSw4ZTEZTd53gofh62WWcEBtu8UlcmP8IoFkFze3IcPwrBEn1ETum24lkdOOOAj1jAi7uKv3xyTp8HMiY32E1aeJ8kHqrNX1iI+VD3 1234defgsigeru@gmail.com'
        ),
        dict(
            name='yoshiki',
            uid=1001,
            sudo='true',
            pub='jjjjjjjjjjjjjjjjjjjjjjjjjj'
        ),
        dict(
            name='takano',
            uid=1002,
            sudo='false',
            pub='eeeeeeeeeeeeeeeeeeee'
        ),
    ]

    return user_list


if __name__ == '__main__':
    main()
