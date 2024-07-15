import { ComponentFixture, TestBed } from '@angular/core/testing';
import { StackLayoutComponent } from './stack-layout.component';

describe('StackLayoutComponent', () => {
  let component: StackLayoutComponent;
  let fixture: ComponentFixture<StackLayoutComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [StackLayoutComponent],
    }).compileComponents();

    fixture = TestBed.createComponent(StackLayoutComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
