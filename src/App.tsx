function App() {
  return (
    <div>
      <h1>TypeScript 5.3.3 + @vitejs/plugin-react-swc 4.2.2 Bug Reproduction</h1>
      <p>Run <code>npm run build</code> to see the TypeScript error:</p>
      <pre>
        node_modules/@vitejs/plugin-react-swc/index.d.ts(58,44): error TS1003: Identifier expected.
        node_modules/@vitejs/plugin-react-swc/index.d.ts(58,61): error TS1128: Declaration or statement expected.
      </pre>
      <p>The issue is caused by string literal export names which require TypeScript 5.5+</p>
    </div>
  )
}

export default App