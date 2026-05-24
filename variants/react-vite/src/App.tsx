import { cn } from "@/lib/utils";

function App() {
  return (
    <main className={cn("min-h-svh grid place-items-center bg-background text-foreground")}>
      <div className="text-center space-y-2">
        <h1 className="text-3xl font-semibold tracking-tight">__PROJECT_NAME__</h1>
        <p className="text-sm text-muted-foreground">React + Vite skeleton. Ready to build.</p>
      </div>
    </main>
  );
}

export default App;
