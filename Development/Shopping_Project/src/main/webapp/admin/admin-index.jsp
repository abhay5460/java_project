<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" :class="{ 'theme-dark': dark }" x-data="data()">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="./assets/css/tailwind.output.css">
    <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
    <script src="./assets/js/init-alpine.js"></script>
    <style>
        .password-wrapper {
            position: relative;
        }
        .password-wrapper input {
            width: 100%;
            padding-right: 2.5rem;
        }
        .password-wrapper .toggle-password {
            position: absolute;
            top: 50%;
            right: 0.5rem;
            transform: translateY(-50%);
            cursor: pointer;
        }
        .btn-creative {
            background: linear-gradient(90deg, #6a11cb 0%, #2575fc 100%);
            border: none;
            color: white;
            font-weight: bold;
            padding: 10px 20px;
            border-radius: 5px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease-in-out;
        }
        .btn-creative:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
	
    <div class="flex items-center min-h-screen p-6 bg-gray-50 dark:bg-gray-900">
        <div class="flex-1 h-full max-w-4xl mx-auto overflow-hidden bg-white rounded-lg shadow-xl dark:bg-gray-800">
            <div class="flex flex-col overflow-y-auto md:flex-row">
                <div class="h-32 md:h-auto md:w-1/2">
                    <img aria-hidden="true" class="object-cover w-full h-full dark:hidden" src="https://png.pngtree.com/thumb_back/fh260/background/20240726/pngtree-the-himalayas-in-nepal-image_15927111.jpg" alt="Office">
                    <img aria-hidden="true" class="hidden object-cover w-full h-full dark:block" src="https://png.pngtree.com/thumb_back/fh260/background/20240726/pngtree-the-himalayas-in-nepal-image_15927111.jpg" alt="Office">
                </div>
                <div class="flex items-center justify-center p-6 sm:p-12 md:w-1/2">
                    <div class="w-full">
                        <h1 class="mb-4 text-xl font-semibold text-gray-700 dark:text-gray-200">Login</h1>
                         <h4 style="color:red">
                           ${message2}
                        </h4>
                        
                        <form method="post" action="../adminController">
                            <label class="block text-sm">
                                <span class="text-gray-700 dark:text-gray-400">Email</span>
                                <input type="email" name="email" placeholder="Enter Your Email" class="block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input">
                            </label>
                            <label class="block mt-4 text-sm">
                                <span class="text-gray-700 dark:text-gray-400">Password</span>
                                <div class="password-wrapper">
                                    <input type="password" name="password" placeholder="Enter Your Password" class="block w-full mt-1 text-sm dark:border-gray-600 dark:bg-gray-700 focus:border-purple-400 focus:outline-none focus:shadow-outline-purple dark:text-gray-300 dark:focus:shadow-outline-gray form-input">
                                    <span class="toggle-password dark:text-gray-300">👁️</span>
                                </div>
                            </label>
                            <button type="submit" name="action" value="login" class="btn-creative mt-6 w-full py-3">Login</button>
                        </form>
                         
                        <hr class="my-8">
                       <!--   <p class="mt-4">
                            <a href="./pages/forgot-password.jsp" class="text-sm font-medium text-purple-600 dark:text-purple-400 hover:underline">Forgot your password?</a>
                        </p>-->
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        document.querySelector('.toggle-password').addEventListener('click', function (e) {
            const passwordInput = document.querySelector('[name="password"]');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            this.textContent = type === 'password' ? '👁️' : '🙈';
        });
    </script>
</body>
</html>