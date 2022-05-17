module.exports = {
  env: {
    browser: true,
    node: true,
    es6: true,
    jest: true,
  },
  extends: ['plugin:react/recommended', 'airbnb', 'prettier'],
  parser: 'babel-eslint',
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 12,
    sourceType: 'module',
  },
  plugins: ['react', 'prettier', 'react-hooks', 'simple-import-sort'],
  rules: {
    eqeqeq: ['error', 'smart'],
    'import/no-unresolved': ['error', { caseSensitive: false }],
    'no-use-before-define': ['error', { variables: false }],
    'prettier/prettier': 'error',
    'react/jsx-one-expression-per-line': 'off',
    'react/no-multi-comp': 'off',
    'react/no-unescaped-entities': 'off',
    'react/prop-types': 'off',
    'react-hooks/rules-of-hooks': 'error',
    'react-hooks/exhaustive-deps': 'warn',
    'simple-import-sort/imports': 'error',
    'simple-import-sort/exports': 'error',
  },
  settings: {
    'import/resolver': {
      node: {
        paths: ['app/javascript'],
      },
    },
  },
};