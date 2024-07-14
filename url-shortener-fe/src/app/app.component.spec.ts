import { TestBed } from '@angular/core/testing';
import { AppComponent } from './app.component';
import { RouterModule } from '@angular/router';
import { By } from '@angular/platform-browser';

describe('AppComponent', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppComponent, RouterModule.forRoot([])],
    }).compileComponents();
  });

  it('should container router outlet', () => {
    const fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges()

    const outletElement = fixture.debugElement.query(By.css('router-outlet'))
    expect(outletElement).toBeTruthy();
  })

  it('should render title', () => {
    const fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges();
    const compiled = fixture.nativeElement as HTMLElement;
    expect(compiled.querySelector('h1')?.textContent).toContain(
      "URL Shortener"
    );
  });

  // it(`should have as title 'url-shortener-fe'`, () => {
  //   const fixture = TestBed.createComponent(AppComponent);
  //   const app = fixture.componentInstance;
  //   expect(app.title).toEqual('url-shortener-fe');
  // });
});
