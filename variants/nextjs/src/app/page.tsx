import { cn } from "@/lib/utils";

export default function Home() {
  return (
    <main className={cn("min-h-svh grid place-items-center bg-background text-foreground")}>
      <div className="text-center space-y-2">
        <h1 className="text-3xl font-semibold tracking-tight">__PROJECT_NAME__</h1>
        <p className="text-sm text-muted-foreground">Next.js skeleton. Ready to build.</p>
      </div>
    </main>
  );
}
